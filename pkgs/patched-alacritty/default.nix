{ lib
, stdenvNoCC
, fetchFromGitHub
, alacritty
, writeScriptBin
, nixosVersion
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
  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "alacritty";
    rev = "cc5b2c0d861eb7a860d6ba3b1b5130ab1411463d";
    sha256 = "0pm3m20hck4zdvaadms8kr3fcnrwnsq06i9x21lw8zq55yic1vq5";
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
  postInstall = lib.concatStringsSep "\n" (
    lib.filter (l: builtins.match ".*gzip -c.*extra/alacritty-msg.man.*" l == null)
    (lib.splitString "\n" old.postInstall)
  );

  cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
    inherit src;
    outputHash = if nixosVersion == "master"
      then "sha256-NLu33oala10xay8n0VLkkm3BoTv6zaAFtTfRI309qxs="
      else "sha256-NLu33oala10xay8n0VLkkm3BoTv6zaAFtTfRI309qxs=";
    doCheck = false;
  });
  patches = [];
})
