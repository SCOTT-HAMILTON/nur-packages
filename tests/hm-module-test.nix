{ hmModule, hmModuleConfig }:

({home-manager
, pkgs
, nixpkgs
}:
import "${nixpkgs}/nixos/tests/make-test-python.nix" ({ pkgs, ...}: {
    system = "x86_64-linux";
    nodes.machine = { ... }: {
      imports = [ "${home-manager}/nixos" ];
      users.users.bob = {
        isNormalUser = true;
        description = "Bob Foobar";
        password = "foobar";
      };
      home-manager.users.bob = { pkgs, ... }: {
        imports = [ hmModule hmModuleConfig ];
      };
    };
    testScript = ''
      start_all()

      machine.succeed("systemctl restart home-manager-bob.service -l 1>&2")
    '';
}))
