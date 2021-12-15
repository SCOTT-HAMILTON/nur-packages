{ lib
, mkDerivation
, fetchFromGitHub
, meson
, ninja
, pkg-config
, cmake
, qtbase
, argparse
, brotli
, c-ares
, cppzmq
, drogon
, jsoncpp
, libconfig
, libuuid
, openssl
, sqlite
, systemd
, tbb
, zeromq
}:

mkDerivation {
  pname = "rpi-fan-serve";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "rpi-fan-serve";
    rev = "591353ef1aedd1a5123a34bd869c1eb42eccb9b2";
    sha256 = "041qmkvz60qddhdqwl7n9xnsmbj10jmjfgv1rhz7zbaxbja87r57";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config ninja meson cmake ];

  buildInputs = [
    argparse
    brotli
    c-ares
    cppzmq
    drogon
    jsoncpp
    libconfig
    libuuid
    openssl
    sqlite
    systemd
    tbb
    zeromq
    qtbase
  ];

  dontWrapQtApps = true;

  meta = with lib; {
    description = "A web service to access rpi-fan data";
    license = licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/rpi-fan-serve";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
