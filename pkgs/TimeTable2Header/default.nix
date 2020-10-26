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

  # src = fetchFromGitHub {
  #   owner = "SCOTT-HAMILTON";
  #   repo = "TimeTable2Header";
  #   rev = "4bc1c6d98e7bdfa998a2a0617bf300654f83d3bc";
  #   sha256 = "1nllxka4gr9jfrqpchg73ryx9lvpbw1d28fz5q9jd1352islgv5j";
  # };

  src = ./src.tar.gz;

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
