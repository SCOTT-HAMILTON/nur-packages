{ nixpkgs ? <nixpkgs>
, pkgs ? import nixpkgs { }
, selfnur
, modules
}:
let
  home-manager = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "home-manager";
    rev = "63dccc4e60422c1db2c3929b2fd1541f36b7e664";
    sha256 = "0caa4746rg0ip2fkhwi1jklavk4lfgx1qvillrya6r3c2hbyx4rm";
  };
in rec {
  sync-database = pkgs.callPackage ./sync-database.nix {
    inherit modules home-manager nixpkgs pkgs;
    inherit (selfnur) sync-database android-platform-tools;
  };
}

