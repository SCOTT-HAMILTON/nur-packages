{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, cmake
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

  # src = fetchFromGitHub {
  #   owner = "SCOTT-HAMILTON";
  #   repo = "rpi-fan-serve";
  #   rev = "c0869235ad5eda2b40d0e8691742a74f65724d88";
  #   sha256 = "0iw3szycraam4whg2sc3riw3rh3pc0d10cn7i836bjq7fla6vgai";
  # };
  src = ~/GIT/src.tar.gz;

  nativeBuildInputs = [ pkg-config ninja meson cmake ];

  buildInputs = [
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
