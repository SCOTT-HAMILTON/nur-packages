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
  callTest = t: t.test;
  hmTest = p: hm-module-test: 
    (import p {
      inherit modules hm-module-test;
    }) {
      inherit home-manager pkgs nixpkgs;
    };
  handleHmTest = p: hm-module-test:
    callTest ((hmTest p hm-module-test) {});
  handleTest = p: args:
    callTest ((import p args) {});
in rec {
  sync-database = handleTest ./sync-database.nix {
    inherit modules home-manager nixpkgs pkgs;
    inherit (selfnur) sync-database android-platform-tools;
  };
  unoconvservice = handleTest ./unoconvservice.nix {
    inherit modules home-manager nixpkgs pkgs;
  };
  hm-module-test = import ./hm-module-test.nix;
  myvim = handleHmTest ./myvim.nix hm-module-test;
  day-night-plasma-wallpapers =
    handleHmTest ./day-night-plasma-wallpapers.nix hm-module-test;
  redshift-auto = handleHmTest ./redshift-auto.nix hm-module-test;
  pronotebot = handleHmTest ./pronotebot.nix hm-module-test;
  pronote-timetable-fetch =
    handleHmTest ./pronote-timetable-fetch.nix hm-module-test;
}

