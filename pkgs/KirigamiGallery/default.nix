{ lib
, mkDerivation
, fetchFromGitHub
, cmake
, extra-cmake-modules
, qtbase
, qtquickcontrols2
, kitemmodels
, kactivities
, kirigami2
}:

mkDerivation rec {
  pname = "KirigamiGallery";
  version = "22.08.2";

  src = fetchFromGitHub {
    owner = "KDE";
    repo = "kirigami-gallery";
    rev = "v${version}";
    sha256 = "sha256-FMWT6+2giL4HLir5PpPC7iFiWvIGtLvUv5bPwYpVBS4=";
  };

  nativeBuildInputs = [ extra-cmake-modules cmake  ];
  buildInputs = [ qtquickcontrols2 kactivities qtbase kirigami2 ];
  propagatedBuildInputs = [ kitemmodels ];

  meta = with lib; {
    description = "View examples of Kirigami components";
    license = licenses.lgpl2;
    homepage = "https://kde.org/applications/en/development/org.kde.kirigami2.gallery";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
