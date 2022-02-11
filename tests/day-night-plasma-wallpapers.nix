{ modules
, hm-module-test
}:

hm-module-test {
  hmModule = modules.hmModules.day-night-plasma-wallpapers;
  hmModuleConfig = {
    services.day-night-plasma-wallpapers = {
      enable = true;
      onCalendar = "*-*-* 16:02:01";
      sleepDuration = 60;
    };
  };
}
