{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, icu
}:

stdenv.mkDerivation rec {
  pname = "pdf-text-extraction";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "galkahana";
    repo = "pdf-text-extraction";
    rev = "f6b78cffeab0529a5b0c9b517be589a88e14e651";
    sha256 = "03091abh8irass08233j2ybgv5rcq5rj2smzs5pp4ql3fbkd3i5w";
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
