{ modules
, hm-module-test
}:

hm-module-test {
  hmModule = modules.hmModules.pronote-timetable-fetch;
  hmModuleConfig = {
    pronote-timetable-fetch = {
      enable = true;
      url = "https://foourl.com";
      username = "foousername";
      password = "12345abc";
    };
  };
}
