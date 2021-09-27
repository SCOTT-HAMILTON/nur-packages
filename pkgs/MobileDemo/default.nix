{ lib
, stdenvNoCC
, ffmpeg
}:
let
in
stdenvNoCC.mkDerivation rec {
  pname = "MobileDemo";
  version = "unstable";
  
  mobiledemo = ./mobiledemo.sh;
  maquette = ./maquette.png;
  dontUnpack = true;

  postPatch = ''
    cp $mobiledemo mobiledemo.sh
    cp $maquette maquette.png
    substituteInPlace mobiledemo.sh \
      --replace "maquette.png" "$out/share/maquette.png"
  '';

  installPhase = ''
    runHook preInstall
    install -Dm 755 mobiledemo.sh "$out/bin/mobiledemo"
    install -Dm 644 maquette.png "$out/share/maquette.png"
    runHook postInstall
  '';

  propagatedBuildInputs = [ ffmpeg ];

  meta = with lib; {
    description = "Argument Parser for Modern C++";
    license = licenses.mit;
    homepage = "https://github.com/p-ranav/argparse";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
