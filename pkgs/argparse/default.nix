{ lib
, stdenv
, fetchFromGitHub
, cmake
}:

stdenv.mkDerivation rec {
  pname = "argparse";
  version = "2.6";

  src = fetchFromGitHub {
    owner = "p-ranav";
    repo = "argparse";
    rev = "v${version}";
    sha256 = "sha256-imLDuVbzkiE5hcQVarZGeNzNZE0/8LHMQqAiUYzPVks=";
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
