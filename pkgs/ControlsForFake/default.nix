{ pkgs
, lib
, mkDerivation
, fetchFromGitHub
, meson
, ninja
, pkg-config
, qtbase
, qttranslations
, qtquickcontrols2
, FakeMicWavPlayer
, pulseaudio
}:
mkDerivation rec {

  pname = "ControlsForFake";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "ControlsForFake";
    rev = "master";
    sha256 = "0czlxm4vdq6v0458gjc5hjyifvvd79nl8kkp3p24s5wm538c440l";
  };

  nativeBuildInputs = [ qttranslations qtbase pkg-config ninja meson ];

  buildInputs = [ qtquickcontrols2 qtbase pulseaudio FakeMicWavPlayer ];

  postPatch = ''
    substituteInPlace controls-for-fake.desktop \
      --replace @Prefix@ "$out"
  '';

  meta = with lib; {
    description = "The Qt gui frontend for FakeMicWavPlayer";
    license = licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/ControlsForFake";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
