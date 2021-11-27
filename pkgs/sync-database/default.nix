{ lib
, python3Packages
, fetchFromGitHub
, parallel-ssh
, libssh2
, merge-keepass
}:

python3Packages.buildPythonPackage rec {
  pname = "sync-database";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "sync-database";
    rev = "459bd88fbe3d9cfb22acc04e60025d23cdb58be1";
    sha256 = "0qix2xrbwfaawd77gy3kpwkbhq6pc774b0567bsv9zc7p9h129nc";
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
  };
}
