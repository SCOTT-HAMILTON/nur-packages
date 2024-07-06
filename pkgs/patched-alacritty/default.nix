{ lib
, stdenvNoCC
, fetchFromGitHub
, alacritty
, writeScriptBin
, nixosVersion
, nix-gitignore
, expat
, fontconfig
, freetype
, libGL
, wayland
, libxkbcommon
, zeromq
, libX11
, libXcursor
, libXi
, libXrandr
, libXxf86vm
, libxcb
, patched-tabbed
}:
let
  tabbed-alacritty = writeScriptBin "tabbed-alacritty"
  ''
    #!${stdenvNoCC.shell}
    ${patched-tabbed}/bin/tabbed -cr 2 -w "--working-directory" -x "--xembed-tcp-port" alacritty --embed ""
  '';
  rpathLibs = [
    expat
    fontconfig
    freetype
    libGL
    wayland
    libxkbcommon
    zeromq
    libX11
    libXcursor
    libXi
    libXrandr
    libXxf86vm
    libxcb
  ];
in
alacritty.overrideAttrs (old: rec {
  pname = "${old.pname}-patched";
  # src = nix-gitignore.gitignoreSource [ ] ~/GIT/alacritty;
  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "alacritty";
    rev = "c138011150c2457b08ef9e7ccf87d6aa27f5d645";
    sha256 = "sha256-DZu1YBcXEd0uQ3woZGx6IC/bqu1RWhf1OFXEXhmKfjs=";
  };
  postPatch = ''
    sed -Ei 's|^Exec=alacritty|Exec=${tabbed-alacritty}/bin/tabbed-alacritty|g' "extra/linux/Alacritty.desktop"
  '';
  buildInputs = (old.buildInputs or []) ++ [ zeromq ];
  propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [ tabbed-alacritty ];
  doCheck = false;
  postFixup = ''
    patchelf --set-rpath "${lib.makeLibraryPath rpathLibs}" "$out/bin/alacritty"
  '';
  postInstall = let
    prepatched =
      builtins.replaceStrings ["install -D extra/linux/org.alacritty.Alacritty.appdata.xml -t $out/share/appdata/"] [""] old.postInstall;
    # install -D extra/linux/org.alacritty.Alacritty.appdata.xml -t $out/share/appdata/
  in lib.concatStringsSep "\n" (
    lib.filter (l: builtins.match ".*gzip -c.*extra/alacritty-msg.man.*" l == null)
    (lib.splitString "\n" prepatched)
  );

  cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
    inherit src;
    outputHash = if nixosVersion == "master"
      then "sha256-P4ZQSXNqREZhllAtalzxTrJRC6R06UHEQwsmi2ugH/s="
      else "sha256-P4ZQSXNqREZhllAtalzxTrJRC6R06UHEQwsmi2ugH/s=";
    doCheck = false;
  });
  patches = [];
})
