{ lib
# , fetchFromGitHub
, buildGoApplication
, nix-gitignore
, pkg-config
, SDL2
, SDL2_ttf
}:
buildGoApplication {
  pname = "Go-pathfinder";
  version = "1.0";

  # src = fetchFromGitHub {
  #   owner = "SCOTT-HAMILTON";
  #   repo = pname;
  #   rev = "d94328dae048346554396f34ea608ad68bacaf3b";
  #   sha256 = "sha256-1aNIOvq7R66mJFX7XtYEVXV7GWITCmTm4aXVz/jlupU=";
  # };
  src = nix-gitignore.gitignoreSource [ ] ~/GIT/Go-pathfinder;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ SDL2 SDL2_ttf ];
  ldflags = [ "-X 'main.assetsDir=${placeholder "out"}/share/assets/'" ];

  postInstall = ''
    install -Dm 644 F25_Bank_Printer.ttf "$out/share/assets/F25_Bank_Printer.ttf"
  '';

  modules = ./gomod2nix.toml;

  meta = with lib; {
    description = "Argument Parser for Modern C++";
    license = licenses.mit;
    homepage = "https://github.com/p-ranav/argparse";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
