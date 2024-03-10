{ lib
, python3Packages
, fetchFromGitLab
, inkscape
, qttools
, wrapQtAppsHook
, qtbase
, opencv2
}:

python3Packages.buildPythonApplication rec {
  pname = "pymecavideo";
  version = "8.0rc10";

  src = fetchFromGitLab {
    owner = "oppl";
    repo = "pymecavideo";
    rev = "v8.0_rc10";
    sha256 = "sha256-uc2GDjWVKGDPSZBLUb4+KE+uYm0g4vU++McvzH4xySQ=";
  };

  nativeBuildInputs = [ inkscape qttools wrapQtAppsHook python3Packages.pyqt6 ];

  patches = [ /tmp/tmp.diff ];

  preBuild = ''
    cd src
    make LRELEASE="lrelease" RCC="${qtbase.dev}/bin/rcc"
    cd ..
  '';

  propagatedBuildInputs = with python3Packages; [
    pyqt6
    numpy
    magic
    opencv4
    pyqtgraph
  ];

  doCheck = false;

  meta = with lib; {
    description = ''GUI automation Python module for human beings'';
    homepage = "https://github.com/asweigart/pyautogui";
    license = licenses.bsd3;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
