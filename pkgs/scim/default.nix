{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, gnuplot
, which
, bison
, ncurses
}:

stdenv.mkDerivation rec {
  pname = "scim";
  version = "0.8.2";

  src = fetchFromGitHub {
    owner = "andmarti1424";
    repo = "sc-im";
    rev = "v${version}";
    sha256 = "sha256-H+GQUpouiXc/w6GWdkSVvTXZ/Dtb7sUmBLGcpxG3Mts=";
  };

  sourceRoot = "source/src";
  nativeBuildInputs = [ which gnuplot bison pkg-config ];
  buildInputs = [ ncurses ];

  makeFlags = [ "prefix=${placeholder "out"}"];

  meta = with lib; {
    description = "Ncurses spreadsheet program for the terminal";
    license = licenses.lgpl3Plus;
    homepage = "https://github.com/andmarti1424/sc-im";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
