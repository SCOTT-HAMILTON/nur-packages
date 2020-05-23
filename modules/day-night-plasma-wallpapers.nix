{ config, lib, pkgs, options,
  modulesPath
}:

with lib;

let
  cfg = config.services.day-night-plasma-wallpapers;
  shamilton = import (builtins.fetchTarball {
          url = "https://github.com/SCOTT-HAMILTON/nur-packages-template/archive/master.tar.gz";
          sha256 = "0jxblfs0l1khfyp2k1rzjbfcp91gm8h9dyyrh8960730a8nl5zrb";
        }) {};
in {

  options.services.day-night-plasma-wallpapers = {
    enable = mkEnableOption "Day-Night Plasma Wallpapers, a software to update your wallpaper according to the day light";

    package = mkOption {
      type = types.package;
      default = shamilton.day-night-plasma-wallpapers;
      defaultText = "shamilton.day-night-plasma-wallpapers";
      description = "Day-night-plasma-wallpapers derivation to use.";
    };

    onCalendar = mkOption {
      type = types.str;
      default = "*-*-* 16:00:00"; # Run at 4 pm everyday (16h)
      description = "When in the evening do you want your wallpaper to go to bed. Default is at 4 pm. See systemd.time(7) for more information about the format.";
    };
  };

  config = {
    systemd.user.services.day-night-plasma-wallpapers = {
      description = "Day-night-plasma-wallpapers: a software to update your wallpaper according to the day light";
      path = [ pkgs.qt5.qttools.bin cfg.package ];
      script = ''${cfg.package}/bin/update-day-night-plasma-wallpapers.sh'';
    };
    environment.systemPackages = [ cfg.package ];
    systemd.user.timers.day-night-plasma-wallpapers = {
      description = "Day-night-plasma-wallpapers timer updating the wallpapers according to sun light";
      partOf = [ "day-night-plasma-wallpapers.service" ];
      wantedBy = [ "timers.target" ];

      timerConfig.OnCalendar = cfg.onCalendar;
      # start immediately after computer is started:
      # timerConfig.Persistent = "true";
    };
  };
}
