{ lib
, stdenvNoCC
, fetchFromGitHub
, alacritty
, writeScriptBin
}:
let
  tabbed-alacritty = writeScriptBin "tabbed-alacritty"
  ''
    #!${stdenvNoCC.shell}
    tabbed -cr 2 -w "--working-directory" -x "--xembed-tcp-port" alacritty --embed ""
  '';
in
alacritty.overrideAttrs (old: rec {
  pname = "${old.pname}-patched";
  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "alacritty";
    rev = "6890c6d47c276e6fa84f769a3fb8dc93add72e1e";
    sha256 = "0gpacmqicbxbw3c674r6ydc0dnjqb9k06gnkxkadqijpkcnpri69";
  };
  postPatch = ''
    sed -Ei 's|^Exec=alacritty|Exec=${tabbed-alacritty}/bin/tabbed-alacritty|g' "extra/linux/Alacritty.desktop"
  '';
  propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [ tabbed-alacritty ];
  doCheck = false;
  cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
    inherit src;
    outputHash = "0nbj4gw0qpv6l11rr2mf3sdz9a2qkgp7cfj9g7zkzzg4b53d9s6x";
    doCheck = false;
  });
})
