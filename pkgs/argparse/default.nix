{ lib
, stdenv
, fetchFromGitHub
, cmake
}:
stdenv.mkDerivation rec {

  pname = "argparse";
  version = "2.2";

  src = fetchFromGitHub {
    owner = "p-ranav";
    repo = "argparse";
    rev = "v${version}";
    sha256 = "1vmn71c2frbhybli8k06kcmb5qdzgqf5gzz90aqf818s6xpv5j0n";
  };

  postPatch = ''
    sed -i '/string(REPLACE/d' CMakeLists.txt
    substituteInPlace 'CMakeLists.txt' \
      --replace 'CMAKE_INSTALL_LIBDIR_ARCHIND' 'CMAKE_INSTALL_LIBDIR'
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
