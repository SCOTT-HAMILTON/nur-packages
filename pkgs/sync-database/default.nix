{ lib
, buildPythonPackage
, fetchFromGitHub
, parallel-ssh
, libssh2
, merge-keepass
, pykeepass
, click
}:

buildPythonPackage rec {
  pname = "sync-database";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "sync-database";
    rev = "45824302a8e4064ca1714545313b2ac9e3fa8778";
    sha256 = "1fv60ysqcv6ssz9fvzncg4vcss4hjyfd9fj4dg78cr5vgva6m9wb";
  };

  propagatedBuildInputs = [ libssh2 parallel-ssh merge-keepass pykeepass click ];
  
  doCheck = false;
  
  makeWrapperArgs = [
    "--set LD_LIBRARY_PATH \"${libssh2}/lib\""
  ];

  meta = with lib; {
    description = "Keepass databases synching script to ssh servers and phone";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
