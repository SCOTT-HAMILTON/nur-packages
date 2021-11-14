{ lib
, stdenv
, fetchFromGitHub
, lbstanza-bin
}:

stdenv.mkDerivation rec {
  pname = "lbstanza";
  version = "master";

  src = fetchFromGitHub {
    owner = "StanzaOrg";
    repo = "lbstanza";
    rev = "37f6caa2e7668b53b8a790ad1b53d9773d648dcf";
    sha256 = "19dm0fqnpw0h52m11fw9r10622r3y4bjs9dl4204shvdrv71gmq0";
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
