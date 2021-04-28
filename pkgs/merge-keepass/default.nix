{ lib
, buildPythonPackage
, fetchFromGitHub 
, pykeepass
, click
, pytest
}:

buildPythonPackage rec {
  pname = "merge-keepass";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "merge-keepass";
    rev = "730c64c8a53f8d3260d42f22b751e2fb3d874d45";
    sha256 = "1rj1j5ck6rf3mb7dbhppwhr39ni301id973hgmrjs527vylsfd8c";
  };

  propagatedBuildInputs = [ pykeepass click ];
  checkInputs = [ pytest ];

  checkPhase = ''
    pytest tests.py
  '';

  doCheck = true;

  meta = with lib; {
    description = "Keepass Databases Merging script";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
