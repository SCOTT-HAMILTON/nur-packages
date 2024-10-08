{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
, pkg-config
, wrapGAppsHook
, gtk3
, portaudio
, fftwFloat
}:

stdenv.mkDerivation rec {
  pname = "tg";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "vacaboja";
    repo = "tg";
    rev = "v${version}";
    sha256 = "1ih1hpj9ak15i47mljhkv7rrq49xm0gdl4n71zygq0pymwxlvg09";
  };
  
  buildInputs = [ gtk3 portaudio fftwFloat ];
  nativeBuildInputs = [ pkg-config autoreconfHook wrapGAppsHook ];

  meta = with lib; {
    description = "Program for timing mechanical watches";
    license = licenses.gpl2Plus;
    homepage = "https://github.com/vacaboja/tg";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
