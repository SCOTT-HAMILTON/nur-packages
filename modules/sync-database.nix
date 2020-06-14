{ config, lib, pkgs, options,
home, modulesPath
}:

with lib;

let
  cfg = config.sync-database;
in {

  options.sync-database = {
    enable = mkEnableOption "Keepass databases 1.x/2.x management utility to synchronize them accross ssh servers and phones";

    hosts = mkOption {
      type = types.attrs;
      default = {};
      example = {
        host1 = {
          user = "root";
          port = 22;
        };
      };
      description = "SSH server hosts configuration";
    };

    passwords_directory = mkOption {
      type = types.str;
      default = "~/.local/share/passwords";
      description = "Directory where password databases are stored accros your servers and localhost.";
    };

    backup_history_directory = mkOption {
      type = types.str;
      default = "~/.local/share/passwords/history_backup";
      description = "Directory to put the backup tarballs of older passwords";
    };
  };
  config = mkIf cfg.enable (mkMerge ([
    {
      home.file.".config/sync-database.conf".text = builtins.toJSON cfg;
    }
  ]));
}
