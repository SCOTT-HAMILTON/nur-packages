{ home-manager
, modules
, pkgs
}:

import "${pkgs.path}/nixos/tests/make-test-python.nix" ({ pkgs, ...}: {
    nodes.machine =
      { ... }:
      {
        imports = [ modules.syspass ]; 
        services.syspass = {
          enable = true;
          domain = "mysyspass.me";
        };
        networking.hosts = {
          "127.0.0.1" = [ "mysyspass.me" ];
        };
      };

    testScript = ''
      start_all()
    
      machine.wait_for_unit("nginx.service")
      machine.wait_for_unit("phpfpm-syspass.service")
      out = machine.succeed(
        '${pkgs.curl}/bin/curl -kiLs https://mysyspass.me | grep "HTTP/2 200"'
      )
      print(out)
    '';
})
