{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, icu
}:

stdenv.mkDerivation rec {
  pname = "pdf-text-extraction";
  version = "2022-12-11";

  src = fetchFromGitHub {
    owner = "galkahana";
    repo = "pdf-text-extraction";
    rev = "46758f25065606c93637ac330a3830a8090d9eb6";
    sha256 = "sha256-aTbTeH77CUPFvS7gtfU4jHEvx7AKqpL8p878ET37kOI=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ icu ];

  cmakeFlags = ["-DUSE_BIDI=1"];

  meta = with lib; {
    description = "cli for extracting text from PDF files";
    license = licenses.asl20;
    homepage = "https://github.com/galkahana/pdf-text-extraction";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
