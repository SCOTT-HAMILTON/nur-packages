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
  hmTest = p: hm-module-test: 
    pkgs.callPackage (import p {
      inherit modules hm-module-test;
    }) {
      inherit home-manager pkgs nixpkgs;
    };
in rec {
  sync-database = pkgs.callPackage ./sync-database.nix {
    inherit modules home-manager nixpkgs pkgs;
    inherit (selfnur) sync-database android-platform-tools;
  };
  unoconvservice = pkgs.callPackage ./unoconvservice.nix {
    inherit modules home-manager nixpkgs pkgs;
  };
  hm-module-test = import ./hm-module-test.nix;
  myvim = hmTest ./myvim.nix hm-module-test;
  day-night-plasma-wallpapers =
    hmTest ./day-night-plasma-wallpapers.nix hm-module-test;
  redshift-auto = hmTest ./redshift-auto.nix hm-module-test;
  pronotebot = hmTest ./pronotebot.nix hm-module-test;
  pronote-timetable-fetch = hmTest ./pronote-timetable-fetch.nix hm-module-test;
}

