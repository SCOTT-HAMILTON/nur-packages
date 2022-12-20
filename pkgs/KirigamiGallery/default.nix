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
  version = "22.12.0";

  src = fetchFromGitHub {
    owner = "KDE";
    repo = "kirigami-gallery";
    rev = "v${version}";
    sha256 = "sha256-2u9vkfIjPS4Ode34se1CiGila1V1fFir/FD0KQ4cgto=";
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
