{ lib
, mkDerivation
, fetchFromGitHub
, cmake
, extra-cmake-modules
, qtbase
, qtquickcontrols2
, kitemmodels
, kactivities
}:
mkDerivation rec {

  pname = "KirigamiGallery";
  version = "20.12.2";

  src = fetchFromGitHub {
    owner = "KDE";
    repo = "kirigami-gallery";
    rev = "v${version}";
    sha256 = "18jgbhjpbdh2qi7rxyx3bh72ig753bfggqh4l3xk191cv7c3i7g2";
  };

  nativeBuildInputs = [ extra-cmake-modules cmake  ];
  buildInputs = [ qtquickcontrols2 kactivities qtbase ];
  propagatedBuildInputs = [ kitemmodels ];

  meta = with lib; {
    description = "View examples of Kirigami components";
    license = licenses.lgpl2;
    homepage = "https://kde.org/applications/en/development/org.kde.kirigami2.gallery";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
