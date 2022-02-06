{ lib
, fetchFromGitHub
, buildRustPackage
}:

buildRustPackage rec {
  pname = "csview";
  version = "1.0.0-rc.1";

  src = fetchFromGitHub {
    owner = "wfxr";
    repo = "csview";
    rev = "v${version}";
    sha256 = "1jamy7jy8ff7xdglnwbl7839hqamihsl95m1q077xl7l5brc6sm7";
  };

  cargoSha256 = "1my6gl8zq5k7clzapgbf1mmcgq8mmdbhl250rdd1fvfd59wkrwra";
  verifyCargoDeps = true;

  meta = with lib; {
    description = "High performance csv viewer with cjk/emoji support";
    homepage = "https://github.com/wfxr/csview";
    license = licenses.asl20;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
    # needs newer cargo
    broken = true;
  };
}
