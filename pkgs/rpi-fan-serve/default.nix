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
    rev = "d2594ba1d74ffca70c61fba16d8bc58cf069afd0";
    sha256 = "1sf5w38qr8hlkci8x4z28fplpwd93q9g3453bfnva67q03v1r1wj";
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
