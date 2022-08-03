let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  localShamilton = import ../. { };
  digitalocean-config = import ./machines/digitalocean.nix;
in {
  network = {
    description = "Deploiment to test nur-packages modules";
    storage.memory = {};
  };
  defaults = {
    imports = lib.attrValues(
      lib.filterAttrs (n: v: !(lib.isAttrs v)) localShamilton.modules
    );
  };

  bckd1-nixos-ams = { config, pkgs, ... }: {
    imports = [
      (import ./machines/digitalocean.nix {
        hostName = "bckd1-nixos-ams";
      })
      localShamilton.modules.scottslounge
    ];
    deployment = {
      targetEnv = "none";
      targetPort = 22;
      targetHost = "146.190.26.126";
    };
    services.openssh.enable = true;

    services.dolibarr = {
      enable = true;
    };
    # services.kairos = {
    #   enable = true;
    # };
  };
}
