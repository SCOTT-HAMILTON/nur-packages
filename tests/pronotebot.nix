{ modules
, hm-module-test
}:

hm-module-test {
  hmModule = modules.hmModules.pronotebot;
  hmModuleConfig = {
    pronotebot = {
      enable = true;
      username = "foousername";
      password = "12345abc";
      firefox_profile = "~/.local/share/firefox/foopath";
    };
  };
}