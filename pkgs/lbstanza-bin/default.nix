{ lib
, stdenv
, fetchzip
, autoPatchelfHook
, gcc-unwrapped
}:

stdenv.mkDerivation rec {
  pname = "lbstanza-bin";
  version = "0.17.55";

  src = fetchzip {
    url = "http://lbstanza.org/resources/stanza/lstanza_${lib.replaceStrings ["."] ["_"] version}.zip";
    sha256 = "sha256-WbLXkHMTP0zvtNtExdlclj6dnr8pkwCSaqiASllj7dg=";
    stripRoot = false;
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  preBuild = ''
    addAutoPatchelfSearchPath ${gcc-unwrapped.lib}/lib
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp -r * "$out"
    cp "$out/stanza" "$out/bin/stanza"

    runHook postInstall
  '';

  meta = with lib; {
    description = "L.B. Stanza Programming Language";
    license = licenses.mit;
    homepage = "http://lbstanza.org/";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
