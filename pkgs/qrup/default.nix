{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "qrup";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "qrup";
    rev = "60aa628d20b62978ce90779c756f24a82f57f97d";
    sha256 = "06qqj78354jw5pqwb2c21phn5qrrvzws61idyi46x0aij2w0g3i8";
  };

  cargoSha256 = "0r0ann1fcqdj07s9anxqpfcl3n99ll54frmzw9ydqqknp7sw1df4";
  verifyCargoDeps = true;

  meta = with lib; {
    description = "Check if tables and items in a .toml file are lexically sorted";
    homepage = "https://github.com/devinr528/cargo-sort-ck";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
