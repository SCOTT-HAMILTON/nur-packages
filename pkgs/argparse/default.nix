{ lib
, stdenv
, fetchFromGitHub
, cmake
}:

stdenv.mkDerivation rec {
  pname = "argparse";
  version = "2.9";

  src = fetchFromGitHub {
    owner = "p-ranav";
    repo = "argparse";
    rev = "v${version}";
    sha256 = "sha256-vbf4kePi5gfg9ub4aP1cCK1jtiA65bUS9+5Ghgvxt/E=";
  };

  postPatch = ''
    sed -i '/string(REPLACE/d' CMakeLists.txt
    substituteInPlace 'CMakeLists.txt' \
      --replace 'CMAKE_INSTALL_LIBDIR_ARCHIND' 'CMAKE_INSTALL_LIBDIR'
    substituteInPlace 'packaging/pkgconfig.pc.in' \
      --replace '@CMAKE_INSTALL_INCLUDEDIR@' \
                'include'
  '';

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Argument Parser for Modern C++";
    license = licenses.mit;
    homepage = "https://github.com/p-ranav/argparse";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
