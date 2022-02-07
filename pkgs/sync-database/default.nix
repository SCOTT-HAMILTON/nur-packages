{ lib
, python3Packages
, fetchFromGitHub
, parallel-ssh
, libssh2
, merge-keepass
, nixosVersion
}:

python3Packages.buildPythonPackage rec {
  pname = "sync-database";
  version = "2022-02-07";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "sync-database";
    rev = "b1c0b00a1a3f1bb23e76d43d2b8f1d2b24baf009";
    sha256 = "1jvxp0rx7jsb574h3hfa5q1rmxd1fnxmjxbj183iairf3gfip8c6";
  };

  propagatedBuildInputs = with python3Packages; [
    setuptools
    libssh2
    parallel-ssh
    merge-keepass
    pykeepass
    click
  ];
  
  doCheck = false;
  
  makeWrapperArgs = [
    "--set LD_LIBRARY_PATH \"${libssh2}/lib\""
  ];

  meta = with lib; {
    description = "Keepass databases synching script to ssh servers and phone";
    homepage = "https://github.com/SCOTT-HAMILTON/sync-database";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
    broken = nixosVersion == "master";
  };
}
