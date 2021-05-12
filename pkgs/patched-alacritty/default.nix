{ lib
, stdenvNoCC
, fetchFromGitHub
, alacritty
, writeScriptBin
, nixosVersion
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
    rev = "49cd691555463305668fd5fcd57151bda2f389d8";
    sha256 = "01w0qcq2dqhk7hyfv6aav5j5zh76p0pid407h1plcb59bgwk7ix5";
  };
  postPatch = ''
    sed -Ei 's|^Exec=alacritty|Exec=${tabbed-alacritty}/bin/tabbed-alacritty|g' "extra/linux/Alacritty.desktop"
  '';
  propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [ tabbed-alacritty ];
  doCheck = false;
  cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
    inherit src;
    
    outputHash = if nixosVersion == "master" then
      "0nbj4gw0qpv6l11rr2mf3sdz9a2qkgp7cfj9g7zkzzg4b53d9s6x" else
      "1w32nslxz4qg8q4hbjk7rwyzp58zygk8p43n03wf92wn4jyk73lc";
    doCheck = false;
  });
})
