{ lib
, buildPythonPackage
, fetchFromGitHub
, click
, pyyaml
}:

buildPythonPackage rec {
  pname = "Yaml2ProbaTree";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "Yaml2ProbaTree";
    rev = "aaece38f9d00d657101d112f5f8cdd2d1753846d";
    sha256 = "004fvx82gjj38dipl3rwr04zv57312m0r9rnhrvqhndh9ksbjvw2";
  };

  # src = ./src.tar.gz;

  propagatedBuildInputs = [
    click
    pyyaml
  ];

  doCheck = false;

  meta = with lib; {
    description = "Converts a yaml structure to a LaTeX/TiKZ probability tree";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
