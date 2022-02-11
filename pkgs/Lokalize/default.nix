{ lib
, mkDerivation
, fetchFromGitHub
, fetchpatch
, cmake
, pkg-config
, extra-cmake-modules
, qtbase
, kactivities
, hunspell
, qtscript
, kross
, breakpointHook
}:

mkDerivation rec {
  pname = "Lokalize";
  version = "21.04.0";

  src = fetchFromGitHub {
    owner = "KDE";
    repo = "lokalize";
    rev = "v${version}";
    sha256 = "0kj2k40c4hzfvm7acxlwh7w5kq58mps9qcmz2829cp79waihxi17";
  };

  nativeBuildInputs = [ breakpointHook pkg-config extra-cmake-modules cmake  ];

  buildInputs = [ kross qtscript hunspell kactivities qtbase ];

  meta = with lib; {
    description = "Computer-aided translation system";
    longDescription = ''
      Lokalize is the localization tool for KDE software and other
      free and open source software. It is also a general computer-aided
      translation system (CAT) with which you can translate OpenDocument
      files (*.odt). Translate-Toolkit is used internally to extract text
      for translation from .odt to .xliff files and to merge translation
      back into .odt file.
    '';
    homepage = "https://apps.kde.org/lokalize/";
    license = licenses.gpl2Plus;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
