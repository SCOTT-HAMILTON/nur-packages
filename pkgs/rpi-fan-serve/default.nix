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
    rev = "2b6217b5a3191fdb328401af94cb5e66f93e2efd";
    sha256 = "063dbrg1jpnj8qk2za5335bfrhdg72kzas463vw8wy0jwxwn95kp";
    fetchSubmodules = true;
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
