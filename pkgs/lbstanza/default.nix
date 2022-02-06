{ lib
, stdenv
, fetchFromGitHub
, lbstanza-bin
}:

stdenv.mkDerivation rec {
  pname = "lbstanza";
  version = "2022-01-20";

  src = fetchFromGitHub {
    owner = "StanzaOrg";
    repo = "lbstanza";
    rev = "5de4ed1b015bff146079d66bf0a7eeb7325b89df";
    sha256 = "17hwyi5hpppdjarbaqcvc9kjgrd7rx4512fpzmk48649cp84cy5i";
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

  nativeBuildInputs = [ lbstanza-bin ];

  meta = with lib; {
    description = "L.B. Stanza Programming Language";
    license = licenses.mit;
    homepage = "http://lbstanza.org/";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
