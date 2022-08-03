{ config, lib, pkgs, specialArgs, options, modulesPath }:
let
  cfg = config.services.dolibarr;

  myphp = pkgs.php.withExtensions ({ enabled, all }:
    enabled ++ [ all.gnupg ]);
  version = "15.0.3";
  configFile = "/etc/dolibarr/conf.php";
  dolibarr = with pkgs; stdenvNoCC.mkDerivation {
    pname = "dolibarr-src";
    inherit version;
    src = fetchFromGitHub {
      owner = "Dolibarr";
      repo = "dolibarr";
      rev = version;
      sha256 = "sha256-HMOYj93ZvqM0FQjt313yuGj/r9ELqQlnNkg/CxrBjRM=";
    };
    postPatch = ''
      sed -i \
        -e 's|\$conffile = .*|\$conffile = "${configFile}";|g' \
        -e 's|\$conffiletoshow = .*|\$conffiletoshow = "${configFile}";|g' \
        htdocs/filefunc.inc.php
      sed -i \
        -e 's|\$conffile = .*|\$conffile = "${configFile}";|g' \
        -e 's|\$conffiletoshow = .*|\$conffiletoshow = "${configFile}";|g' \
        htdocs/install/inc.php
    '';
    dontBuild = true;
    installPhase = ''
      mkdir -p "$out"
      cp -r * $out
    '';
  };
  app = "dolibarr";
  domain = "${app}.me";
  webroot = "${dolibarr}/htdocs";
  passwordPlaceholder = "__PLACEHOLDER_PASSWORD__";
  uniqueIdPlaceholder = "__PLACEHOLDER_UNIQUE_ID__";
in
with lib; {
  options.services.dolibarr = {
    enable = mkEnableOption "Dolibarr ERP CRM";
    initialDbPasswordFile = mkOption {
      type = with types; nullOr str;
      default = null;
      example = "/run/secrets/dolibarr-db-user-password";
      description = ''
        If not null, the plain-text password contained in this file will be used to
        set the password for the ${app} mysql user. Please make sure the ${config.services.nginx.user}
        user has access to it.
      '';
    };
    rootUrl = mkOption {
      type = types.str;
      example = "http://dolibarr.mycompany.com";
      description = "Root url where user should be able to access dolibarr";
    };
  };
  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    services.phpfpm.pools.${app} = {
      user = app;
      settings = {
        "listen.owner" = config.services.nginx.user;
        "pm" = "dynamic";
        "pm.max_children" = 32;
        "pm.max_requests" = 500;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 2;
        "pm.max_spare_servers" = 5;
        "php_admin_value[error_log]" = "stderr";
        "php_admin_flag[log_errors]" = true;
        "catch_workers_output" = true;
      };
      # phpOptions = ''
      #   extension=${myphp.extensions.gnupg}/lib/php/extensions/gnupg.so
      # '';
      phpEnv = {
        "PATH" = lib.makeBinPath [ myphp ];
        # "GNUPGHOME" = "/var/lib/passbolt/.gnupg";
      };
    };
    services.nginx = {
      enable = true;
      virtualHosts."${domain}" = {
        listen = [{
          addr = "0.0.0.0";
          port = 80;
        }];
        # addSSL = true;
        # enableACME = true;
        root = "${webroot}";
        locations."/" = {
          # tryFiles = "$uri /index.html index.php?$args";
          tryFiles = "$uri $uri/ $uri.php";
          index = "index.php";
        };
        locations."~ \\.php$" = {
          tryFiles = "$uri =404";
          fastcgiParams = {
            SCRIPT_FILENAME = "$document_root$fastcgi_script_name";
            SERVER_NAME = "$http_host";
            PHP_VALUE = "upload_max_filesize=5M \\n post_max_size=5M";
          };
          extraConfig = ''
            fastcgi_pass             unix:${config.services.phpfpm.pools.${app}.socket};
            fastcgi_index            index.php;
            include                  ${pkgs.nginx}/conf/fastcgi_params;
            include                  ${pkgs.nginx}/conf/fastcgi.conf;
            fastcgi_intercept_errors on;
            fastcgi_split_path_info  ^(.+\.php)(.+)$;
          '';
        };
      };
    };

    systemd.services.dolibarr-mysql-db-init = {
      description = "Initialize mysql db for dolibarr";
      wants = [ "mysql.service" ];
      after = [ "mysql.service" ];
      serviceConfig = let
        script =  let
          mysqlPasswordActivation = let
              initialScript = ''
                CREATE USER IF NOT EXISTS '${app}'@'localhost' IDENTIFIED WITH mysql_native_password;
                GRANT ALL PRIVILEGES ON ${app}.* TO '${app}'@'localhost';
                SET PASSWORD FOR '${app}'@'localhost' = PASSWORD('${passwordPlaceholder}');
              '';
            in (if (cfg.initialDbPasswordFile != null) then ''
              tmp_script_file=$(mktemp)
              echo ${escapeShellArg initialScript} > $tmp_script_file
              ${pkgs.replace-secret}/bin/replace-secret '${passwordPlaceholder}' '${cfg.initialDbPasswordFile}' $tmp_script_file
              echo "Creating initial database: ${app}"
              ( echo 'create database `${app}`;') | ${config.services.mysql.package}/bin/mysql -u root -N
              cat $tmp_script_file | ${config.services.mysql.package}/bin/mysql -u root -N
              rm -f $tmp_script_file
            '' else "");
        in ''
          #!${pkgs.runtimeShell}
          # Setup database password
          if ! test -e "${config.services.mysql.dataDir}/${app}"; then
            ${mysqlPasswordActivation}
          fi
        '';
        startScript = pkgs.writeScriptBin "dolibarr-mysql-db-init-start" script;
      in {
        Type = "oneshot";
        ExecStart = "${startScript}/bin/dolibarr-mysql-db-init-start";
      };
    };

    systemd.services.nginx = {
      wants = [ "dolibarr-mysql-db-init.service" ];
      after = [ "dolibarr-mysql-db-init.service" ];
    };
    systemd.services.phpfpm-dolibarr = {
      serviceConfig.ReadWriteDirectories = [
        "/etc/dolibarr"
        "/var/lib/dolibarr/documents"
      ];
    };
    
    system.activationScripts.dolibarr-init-script = let
      initConfig = ''
        <?php

        $dolibarr_main_url_root='${cfg.rootUrl}';
        $dolibarr_main_document_root='${webroot}';
        $dolibarr_main_url_root_alt='/custom';
        $dolibarr_main_document_root_alt='${webroot}/custom';
        $dolibarr_main_data_root='/var/lib/dolibarr/documents';
        $dolibarr_main_db_host='localhost';
        $dolibarr_main_db_port='3306';
        $dolibarr_main_db_name='dolibarr';
        $dolibarr_main_db_prefix='llx_';
        $dolibarr_main_db_user='dolibarr';
        $dolibarr_main_db_pass='${passwordPlaceholder}';
        $dolibarr_main_db_type='mysqli';
        $dolibarr_main_db_character_set='utf8';
        $dolibarr_main_db_collation='utf8_unicode_ci';
        $dolibarr_main_authentication='dolibarr';
        $dolibarr_main_prod='0';
        $dolibarr_main_force_https='0';
        $dolibarr_main_restrict_os_commands='mysqldump, mysql, pg_dump, pgrestore';
        $dolibarr_nocsrfcheck='0';
        $dolibarr_main_instance_unique_id='${uniqueIdPlaceholder}';
        $dolibarr_mailing_limit_sendbyweb='0';
        $dolibarr_main_distrib='standard';
      '';
    in stringAfter [ "etc" "groups" "users" ] ''
      # Setup folders in /var/lib/dolibarr/documents
      mkdir -p /var/lib/dolibarr/documents/{mycompany,medias,users,facture,propale,ficheinter,produit,doctemplates}
      chown -R ${app}:${app} /var/lib/dolibarr
      chmod -R 0700 /var/lib/dolibarr

      # Setup config file
      tmp_hash=$(mktemp)
      head -n 100 /dev/random| md5sum | cut -d' ' -f1 > $tmp_hash
      [ ! -f /etc/dolibarr/conf.php ] && \
        echo ${escapeShellArg initConfig}  > /etc/dolibarr/conf.php && \
        ${pkgs.replace-secret}/bin/replace-secret '${passwordPlaceholder}' '${cfg.initialDbPasswordFile}' /etc/dolibarr/conf.php && \
        ${pkgs.replace-secret}/bin/replace-secret '${uniqueIdPlaceholder}' $tmp_hash /etc/dolibarr/conf.php && \
        chown ${app}:${app} /etc/dolibarr/conf.php && \
        chmod 0600 /etc/dolibarr/conf.php
      rm -f $tmp_hash
    '';

    users.users.${app} = {
      isSystemUser = true;
      createHome = true;
      home = "/etc/dolibarr";
      group = app;
    };
    users.groups.${app} = { };
    networking.firewall.allowedTCPPorts = [ 443 80 ];
    environment.systemPackages = [ myphp ];
  };
}
