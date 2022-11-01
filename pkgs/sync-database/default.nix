{ lib
, python3Packages
, fetchFromGitHub
, parallel-ssh
, libssh2
, merge-keepass
, nixosVersion
, nix-gitignore
}:

python3Packages.buildPythonPackage rec {
  pname = "sync-database";
  version = "2022-11-01";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "sync-database";
    rev = "9f4c9cf5c558be8169d3169a72d82378ef777a4b";
    sha256 = "sha256-H1mDEVgHXch7rzKZusrLAIQZt+6ojri/gvjfklepFnA=";
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
