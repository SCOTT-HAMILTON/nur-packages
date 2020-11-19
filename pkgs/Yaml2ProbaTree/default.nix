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
    rev = "0b7cbb9c28de095ee6059d2b8ae1a7dcb435c22f";
    sha256 = "10rymyswiqa9w81g626yrcpgs87dzfzh222vx3bk8s4mh7xg1wcm";
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
