{ lib
, stdenv
, fetchFromGitHub
, lbstanza-bin
, cmake
}:

stdenv.mkDerivation rec {
  pname = "lbstanza";
  version = "2022-10-31";

  src = fetchFromGitHub {
    owner = "StanzaOrg";
    repo = "lbstanza";
    rev = "6d7b418c140bb041b1f65d8a4186d20bcf9bf98d";
    sha256 = "sha256-87O+v2eiKtIu5lB47dz22iFef1grM7gyBNTkAUkAndE=";
  };

  postPatch = ''
    patchShebangs scripts/*.sh
  '';

  preBuild = ''
    mkdir build
    export HOME=$(pwd)
    cat << EOF > .stanza
      install-dir = "${lbstanza-bin}"
      platform = linux
      aux-file = "mystanza.aux"
    EOF
  '';

  buildPhase = ''
    runHook preBuild
    ./scripts/make.sh stanza linux compile-clean
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir "$out"
    cp -r * "$out"
    mv "$out/lpkgs" "$out/pkgs"
    mv "$out/lstanza" "$out/bin/stanza"
    ln -s "$out/bin/stanza" "$out/stanza"
    runHook postInstall
  '';

  nativeBuildInputs = [ lbstanza-bin cmake ];
  dontUseCmakeConfigure = true;

  meta = with lib; {
    description = "L.B. Stanza Programming Language";
    license = licenses.mit;
    homepage = "http://lbstanza.org/";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
