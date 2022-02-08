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
}:
let
  tabbed-alacritty = writeScriptBin "tabbed-alacritty"
  ''
    #!${stdenvNoCC.shell}
    tabbed -cr 2 -w "--working-directory" -x "--xembed-tcp-port" alacritty --embed ""
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
    rev = "c0b1a42784c6092edbcd72ceae01b3154b53823e";
    sha256 = "1s5skr3vnjs5njypmpdfj6gq97wcbcqsi0yc8bgqpx6did4ya4gg";
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
      then "1cvjg840y1gnxhiw9rjhq27g49ap5vb795qvn9fblqfk3w545z5l"
      else "sha256-zDDRQqShiu5C6KNiLeMhLWgez2+WkV2r+hGj9nZXddk=";
    doCheck = false;
  });
})
