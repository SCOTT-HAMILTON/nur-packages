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

in
with lib; {
  options.services.dolibarr = {
    enable = mkEnableOption "Dolibarr ERP CRM";
    # port = mkOption {
    #   type = types.port;
    #   default = 61694;
    #   description = "Port for gotify to listen";
    # };
  };
  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      initialDatabases = [ { name = app; } ];
      ensureUsers = [{
        name = app;
        ensurePermissions = {
          "${app}.*" = "ALL PRIVILEGES";
        };
      }];
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
    systemd.services.phpfpm-dolibarr = {
      serviceConfig.ReadWriteDirectories = [
        "/etc/dolibarr"
        "/var/lib/dolibarr/documents"
      ];
    };
    
    system.activationScripts.dolibarr-make-documents-folder = ''
      mkdir -p /var/lib/dolibarr/documents/{mycompany,medias,users,facture,propale,ficheinter,produit,doctemplates}
      chown -R ${app}:${app} /var/lib/dolibarr
      chmod -R 0700 /var/lib/dolibarr
    '';

    environment.etc = {
      "dolibarr/conf.php" = {
        user = app;
        group = app;
        mode = "0600";
        source = "${dolibarr}/htdocs/conf/conf.php.example";
      };
    };
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
