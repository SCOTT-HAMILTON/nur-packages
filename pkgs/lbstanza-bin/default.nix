{ lib
, stdenv
, fetchzip
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "lbstanza-bin";
  version = "0.14.33";

  src = fetchzip {
    url = "http://lbstanza.org/resources/stanza/lstanza_${lib.replaceStrings ["."] ["_"] version}.zip";
    sha256 = "1az9pddxh5kjqkkxsl3ffc23zjawilpisnvy9sy7ymnsp3b791lf";
    stripRoot=false;
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp -r * "$out"
    cp "$out/stanza" "$out/bin/stanza"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Argument Parser for Modern C++";
    license = licenses.mit;
    homepage = "https://github.com/p-ranav/argparse";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
