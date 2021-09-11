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
    rev = "3c7edbe0147b1beb9617f213416280c6eb828179";
    sha256 = "1kxd8ssx9sv4whg7w3i5rxhnl8i9apbn5zwnw5sv8gk0sn37f8gd";
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
