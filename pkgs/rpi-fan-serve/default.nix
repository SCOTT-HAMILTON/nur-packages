{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, cmake
, argparse
, brotli
, c-ares
, drogon
, jsoncpp
, libuuid
, openssl
, sqlite
}:

stdenv.mkDerivation {
  pname = "rpi-fan-serve";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "rpi-fan-serve";
    rev = "970b9658a8cb747f51446474b02bd3d6a20d3517";
    sha256 = "10xrqbsiv6hswrq4kvh89wlyqapp5ffwpfiv4fqcx1y59yinpvyn";
  };

  nativeBuildInputs = [ pkg-config ninja meson cmake ];

  buildInputs = [
    argparse
    brotli
    c-ares
    drogon
    jsoncpp
    libuuid
    openssl
    sqlite
  ];

  meta = with lib; {
    description = "A web service to access rpi-fan data";
    license = licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/rpi-fan-serve";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
