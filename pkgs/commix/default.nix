{ lib
, buildPythonApplication
, fetchFromGitHub
, python3Packages
}:

buildPythonApplication rec {
  pname = "commix";
  version = "3.1";

  src = fetchFromGitHub {
    owner = "commixproject";
    repo = "commix";
    rev = "v${version}";
    sha256 = "00y8i6ff2qcbyyfqq2dxmbwpbgd2a4s4pzpjq4l5ln41z31mf3m2";
  };

  propagatedBuildInputs = with python3Packages; [ tornado_4 python-daemon ];

  meta = with lib; {
  };
}
