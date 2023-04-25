{ lib
, python3Packages
, fetchFromGitHub 
}:

python3Packages.buildPythonPackage rec {
  pname = "pytweening";
  version = "2023-04-24";

  src = fetchFromGitHub {
    owner = "asweigart";
    repo = "pytweening";
    rev = "800a5f619b7f99e8bb925b3009ae31ae3260f8e1";
    sha256 = "sha256-fqXN92FfjkI5fOnsVpzStMul5RWmCCvHrB5S5Vamn/Q=";
  };

  doCheck = false;

  meta = with lib; {
    description = "A set of tweening / easing functions implemented in Python";
    homepage = "https://github.com/asweigart/pytweening";
    license = licenses.bsd3;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
