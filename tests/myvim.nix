{ modules
, hm-module-test
}:

hm-module-test {
  hmModule = modules.hmModules.myvim;
  hmModuleConfig = { myvim.enable = true; };
}
