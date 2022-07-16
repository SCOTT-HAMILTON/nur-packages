{ modules
, hm-module-test
}:

hm-module-test {
  hmModule = modules.hmModules.myvim;
  hmModuleConfig = { programs.myvim.enable = true; };
}
