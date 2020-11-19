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
    rev = "f8d0d88339404624a2569f3b885280020fb69fc2";
    sha256 = "1f6z7h5n9vdah7xgcbzx9r90qkngyppy9rcm5g055dv7rci6j940";
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
