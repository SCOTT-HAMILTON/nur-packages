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
    rev = "8acefae5b564bc5cfa74bca68529a05518828b9a";
    sha256 = "0gips2iyns87sk8kbldhrjglg3alara5dnlzrz42b09wkkdlpapx";
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
