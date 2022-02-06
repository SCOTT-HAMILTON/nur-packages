{ lib
, stdenv
, fetchzip
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "lbstanza-bin";
  version = "0.15.11";

  src = fetchzip {
    url = "http://lbstanza.org/resources/stanza/lstanza_${lib.replaceStrings ["."] ["_"] version}.zip";
    sha256 = "1gnbwk0wnbys873c7mxzf1i82v9fnb1iycxawaijicy7yl7c3ff2";
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
