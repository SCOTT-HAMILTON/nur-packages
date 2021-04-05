{ lib
, fetchFromGitHub
, buildRustPackage
}:

buildRustPackage rec {
  pname = "InstantTee";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "ArniDagur";
    repo = "InstantTee";
    rev = "6ada9f50535c19dc20e596f848442e93312fe79b";
    sha256 = "19dpjhjbws4qkdnv7lgzw3fgs7xaxns88xvmkakra027jsabzbn1";
  };

  cargoSha256 = "0zfm6qqm2r6g54vkkdmiqacrp4zwy1zbr62h0p1dmb4vhmfnkb6m";
  verifyCargoDeps = true;

  meta = with lib; {
    description = "Check if tables and items in a .toml file are lexically sorted";
    homepage = "https://github.com/devinr528/cargo-sort-ck";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
