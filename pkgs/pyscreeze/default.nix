{ lib
, python3Packages
, fetchFromGitHub
, xvfb-run
, scrot
}:

python3Packages.buildPythonPackage rec {
  pname = "PyScreeze";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "asweigart";
    repo = "pyscreeze";
    rev = "28ab707dceecbdd135a9491c3f8effd3a69680af";
    sha256 = "16v16r1yw14zmy1nga5lbk448f7s99c1mq0r49hwg6pz6xvg4zc2";
  };

  nativeBuildInputs = [ xvfb-run ];
  propagatedBuildInputs = with python3Packages; [
    pillow
  ];
  checkInputs = with python3Packages; [ pytest xlib scrot ];

  doCheck = true;
  checkPhase = ''
    xvfb-run -s '-screen 0 800x600x24' \
      pytest
  '';

  meta = with lib; {
    description = "Simple, cross-platform screenshot module for Python 2 and 3";
    license = licenses.bsd3;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
