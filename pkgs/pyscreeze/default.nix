{ lib
, python3Packages
, fetchFromGitHub
, xvfb-run
, scrot
}:

python3Packages.buildPythonPackage rec {
  pname = "PyScreeze";
  version = "2022-03-16";

  src = fetchFromGitHub {
    owner = "asweigart";
    repo = "pyscreeze";
    rev = "b693ca9b2c964988a7e924a52f73e15db38511a8";
    sha256 = "sha256-vGQsg15tKE1OHtIywuluX0rpx4s3UhwfmacbCdK79JE=";
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
    homepage = "https://github.com/asweigart/pyscreeze";
    license = licenses.bsd3;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
