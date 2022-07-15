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
  version = "2022-07-15";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "sync-database";
    rev = "e6b91d4dc79e3f329bee1506a6d35afde3ff3e93";
    sha256 = "sha256-dUS9ccy7g+0BqnkKKQC1G1kJfIyh6jOlzrtaxdXN0vI=";
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
