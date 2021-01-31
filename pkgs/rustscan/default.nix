{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "RustScan";
  version = "master";

  src = fetchFromGitHub {
    owner = "RustScan";
    repo = "RustScan";
    rev = version;
    sha256 = "0riwih1sxsh61gmjw3c1hl8gswc6xv5j72mi8v5l2fwh35s4nrs8";
  };

  # postPatch = ''
  #   substituteInPlace Cargo.toml \
  #     --replace 'rlimit = "0.5.2"' 'rlimit = "0.5.3"'
  # '';

  cargoSha256 = "1nsqxpv7if1l07qyaqjv9yai9p8mc01s2jsirwy6lj08cjbj88v5";

  meta = with lib; {
    description = "Compositor for X11";
    license = licenses.mit;
    homepage = "https://github.com/tryone144/compton";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
    # Waiting for https://github.com/RustScan/RustScan/issues/355
    broken = true;
  };
}
