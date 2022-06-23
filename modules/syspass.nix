{ syspass }:
{ config, lib, pkgs, specialArgs, options, modulesPath }:
let
  cfg = config.services.syspass;

  myphp = pkgs.php74;

  app = "syspass";
  domain = "${app}.me";
  webrootDir = "${syspass}";
  dataDir = "/var/lib/${app}";

  show_syspass_root = pkgs.writeScriptBin "show-syspass-root" ''
    #!${pkgs.bash}/bin/sh
    echo ${syspass}
  '';
  make_php_data_folders = let
    user = config.services.nginx.user;
    group = config.services.nginx.group;
  in pkgs.writeScriptBin "make-php-data-folders" ''
    #!${pkgs.bash}/bin/sh
    make_dir(){
      mkdir -p $1
      chown -R ${user}:${group}  $1
      chmod -R 750  $1
    }
    make_dir ${dataDir}/config
    make_dir ${dataDir}/cache
    make_dir ${dataDir}/temp
  '';
in
with lib; {
  options.services.syspass = {
    enable = mkEnableOption "Intuitive, secure and multiuser password manager.";
  };
  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    services.phpfpm = {
      phpPackage = myphp;
      pools.${app} = {
        user = config.services.nginx.user;
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
        phpEnv = {
          "PATH" = lib.makeBinPath [ myphp ];
        };
      };
    };
    systemd.services."phpfpm-${app}" = {
      serviceConfig = {
        User = config.services.nginx.user;
        NoNewPrivileges = true;
        RestrictNamespaces = true;
        CapabilityBoundingSet = [ "" ];
        # Since we only use unix sockets, we can this restriction
        RestrictAddressFamilies = lib.mkForce [ "AF_UNIX" ];
        PrivateNetwork = true;

        ProtectClock = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        SystemCallArchitectures = "native";
        RestrictSUIDSGID = true;
        ProtectKernelTunables = true;
        ProtectProc = "invisible";
        PrivateUsers = true;
        SystemCallFilter = [ "@system-service" ];
        IPAddressDeny = "any";
      };
      after = [ "phpfpm-${app}-prep-folders.service" ];
      wants = [ "phpfpm-${app}-prep-folders.service" ];
    };
    systemd.services."phpfpm-${app}-prep-folders" = {
      description = "Prepares the folder for phpfpm-${app}.service";
      wantedBy = [ "phpfpm-${app}.service" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = [ "${make_php_data_folders}/bin/make-php-data-folders" ];
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "fake.address@example.com";
      defaults.renewInterval = "minutely";
      # we use acme only to generate the preliminarySelfsigned 
      # certs. We don't actually wan't to make real certs with
      # the let's encrypt servers. Giving this to avoid overloading
      # their servers with invalid requests.
      defaults.server = "https://127.0.0.1";
      certs = {
        "${domain}" = {
          webroot = "/var/lib/acme/${app}/certs";
          group = config.services.nginx.group;
        };
      };
      preliminarySelfsigned = true;
    };
    systemd.services."acme-${domain}".enable = false;
    systemd.timers."acme-${domain}".enable = false;
    systemd.targets."acme-finished-${domain}".enable = false;
    services.nginx = {
      enable = true;
      virtualHosts."${domain}" = {
        serverName = app;
        forceSSL = true;
        useACMEHost = "${domain}";

        extraConfig = ''
          error_page 500 502 503 504 /50x.html;
        '';
        locations."\\.htaccess" = {
          extraConfig = ''
            deny all;
          '';
        };
        locations."/" = {
          root = "${webrootDir}";
          tryFiles = "$uri $uri/ =404";
          index = "index.php";
        };
        locations."/50x.html" = {
          extraConfig = ''
            root html;
          '';
        };
        locations."~ \\.php$" = {
          tryFiles = "$uri =404";
          root = "${webrootDir}";
          fastcgiParams = {
            SCRIPT_NAME = "$fastcgi_script_name";
            SCRIPT_FILENAME = "$document_root$fastcgi_script_name";
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
    users.users.${app} = {
      isSystemUser = true;
      group  = app;
    };
    users.users."phpfpm-${app}" = {
      isSystemUser = true;
      group  = app;
    };
    users.groups.${app} = { };
    users.users.nginx.extraGroups = [ "acme" ];
    networking.firewall.allowedTCPPorts = [ 443 80 ];
    environment.systemPackages = [ myphp show_syspass_root ];
  };
}
