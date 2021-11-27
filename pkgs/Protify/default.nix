{ lib
, stdenv
, mkDerivation
, fetchFromGitHub
, qmake
, pkg-config
, qtbase
, qttools
, qtquickcontrols2
, avahi
, cppzmq
, zeromq
, clang_10
}:

mkDerivation {
  pname = "Protify";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "Protify";
    rev = "3e8655ea812352f60340a3a7d156e6e394d12206";
    sha256 = "1a06xrslm399bzwj6rsz3kvli834rz5p2nrrcx1x5bi6svxl9lfl";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ clang_10 qmake qtbase pkg-config qttools ];
  buildInputs = [ qtquickcontrols2 qtbase avahi cppzmq zeromq ];
  qmakeFlags = [ "QMAKE_CXX=clang++" ];
  installFlags = [ "INSTALL_ROOT=$(out)" ];

  preFixup = ''
    qtWrapperArgs+=(--run "export XDG_CACHE_HOME=\$HOME/.local/cache")
  '';

  meta = with lib; {
    description = "Desktop client for Protify";
    license = licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/Protify";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
