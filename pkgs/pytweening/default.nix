{ lib
, python3Packages
, fetchFromGitHub 
}:

python3Packages.buildPythonPackage rec {
  pname = "pytweening";
  version = "2021-09-14";

  src = fetchFromGitHub {
    owner = "asweigart";
    repo = "pytweening";
    rev = "e2fa77c0550817517b8b1235a90ad43b72424e56";
    sha256 = "0lf0irfx2ykjfy1lql3cg7f9xymif7clrgcwravwbxcm2ayv748j";
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
