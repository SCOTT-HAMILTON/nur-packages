{ lib
, fetchFromGitHub
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "nix-bisect";
  version = "2020-09-22";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "nix-bisect";
    rev = "e68fbdede0ad3a5ab9d80850cbee92d8f1823cd1";
    sha256 = "094q3gpixiyn65bz9pqc6ir2abf69i2lgh40ksnbzj0x21y8x1ns";
  };

  propagatedBuildInputs = with python3Packages; [
    appdirs
    numpy
    pexpect
  ];

  doCheck = false;

  meta = with lib; {
    description = "Bisect nix builds";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
