{ lib
, python3Packages
, fetchFromGitHub 
, nixosVersion
}:

python3Packages.buildPythonPackage rec {
  pname = "merge-keepass";
  version = "2021-12-27";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "merge-keepass";
    rev = "4ab69e149be77250e512907ad68a533fb1814462";
    sha256 = "0hwzdgq7mrldr1y40fpfyvka9m6a8g6xhiv0di106lq06l4zcrch";
  };

  propagatedBuildInputs = with python3Packages; [ pykeepass click ];
  checkInputs = with python3Packages; [ pytest ];

  checkPhase = ''
    pytest tests.py
  '';

  doCheck = true;

  meta = with lib; {
    description = "Keepass Databases Merging script";
    homepage = "http://github.com/SCOTT-HAMILTON/merge-keepass";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
    broken = nixosVersion == "master";
  };
}
