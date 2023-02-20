{ lib
, stdenv
, fetchFromGitHub
, lbstanza-bin
, cmake
}:

stdenv.mkDerivation rec {
  pname = "lbstanza";
  version = "2023-01-28";

  src = fetchFromGitHub {
    owner = "StanzaOrg";
    repo = "lbstanza";
    rev = "cea8b5bbf4bd33b43a54e897d56e6c2f28cc68aa";
    sha256 = "sha256-NmJBAvRWAXdu4Ax2QfPG3W4MbplHOmr6klir0Dz7EJ8=";
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
