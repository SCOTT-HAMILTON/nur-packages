{ lib
, buildPythonApplication
, fetchFromGitHub
, click
, setuptools
, pandas
}:

buildPythonApplication rec {
  pname = "CdC-cognitoform-result-generator";
  version = "0.1";

  # src = fetchFromGitHub {
  #   owner = "SCOTT-HAMILTON";
  #   repo = "CdC-cognitoform-result-generator";
  #   rev = "ffffffffffffffffffffffffffffffffffffffff";
  #   sha256 = "0000000000000000000000000000000000000000000000000000";
  # };

  src = ./src.tar.gz;

  propagatedBuildInputs = [
    click
    pandas
    setuptools
  ];

  doCheck = false;

  meta = with lib; {
    description = "Generates a latex formatted output from an xlsx cognitoform excel sheet, made for classes councils preparation.";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
