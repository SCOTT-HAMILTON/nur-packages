{ pkgs }:

with pkgs.lib; let
  builder0 = pkgs.callPackage ./gomod2nix-no-cyclic-deps/builder { };
  gomod2nix0 = pkgs.callPackage ./gomod2nix-no-cyclic-deps { inherit (builder0) buildGoApplication; };
  builder1 = pkgs.callPackage ./gomod2nix/builder { gomod2nix = gomod2nix0; };
  # gomod2nix = pkgs.callPackage ./gomod2nix { inherit buildGoApplication; };
in {
  # Add your library functions here
  #
  # hexint = x: hexvals.${toLower x};
  gomod2nix = { inherit (builder1)  buildGoApplication; };
}

