{ stdenv
, lib
, makeWrapper
, nix-gitignore
# , fetchFromGitHub
, love
}:
stdenv.mkDerivation rec {
  pname = "L-ve3D";
  version = "1.0";

  # src = fetchFromGitHub {
  #   owner = "p-ranav";
  #   repo = "argparse";
  #   rev = "v${version}";
  #   sha256 = "sha256-0fgMy7Q9BiQ/C1tmhuNpQgad8yzaLYxh5f6Ps38f2mk=";
  # };
  src = nix-gitignore.gitignoreSource [ ] ~/GIT/L-ve3D;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p "$out/src/${pname}"
    cp -r ./* "$out/src/${pname}"

    mkdir -p $out/bin
    makeWrapper ${love}/bin/love $out/bin/${pname} \
      --add-flags "$out/src/${pname}"
  '';

  meta = with lib; {
    description = "Argument Parser for Modern C++";
    license = licenses.mit;
    homepage = "https://github.com/p-ranav/argparse";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
