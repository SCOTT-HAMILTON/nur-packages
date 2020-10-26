{ lib
, buildPythonPackage
, fetchFromGitHub 
, click
, numpy
, odfpy
, pandas
}:

buildPythonPackage rec {
  pname = "TimeTable2Header";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "TimeTable2Header";
    rev = "c9b589685e06c5edbf4002f7c16453bd8688cc28";
    sha256 = "1is202fsa6vwcj83kvbwx0jyrvxyhdlr6ciz30m1rn4dgg1hshic";
  };

  # src = ./src.tar.gz;

  propagatedBuildInputs = [
    click
    numpy
    odfpy
    pandas
  ];

  doCheck = false;

  meta = with lib; {
    description = "Keepass Databases Merging script";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
