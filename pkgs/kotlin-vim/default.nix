{ lib
, buildVimPluginFrom2Nix
, fetchFromGitHub
}:

buildVimPluginFrom2Nix {
  pname = "kotlin-vim";
  version = "2021-11-08";

  src = fetchFromGitHub {
    owner = "udalov";
    repo = "kotlin-vim";
    rev = "6fec676fe552cb30165dc8977dab9353c4c3ab26";
    sha256 = "08sz0fmlk4bzzkg5j0zbjd1dki1ykigar4rzyc05xfynvkcxh4fg";
  };

  meta = with lib; {
    description = "Kotlin plugin for Vim";
    license = licenses.asl20;
    homepage = "https://github.com/udalov/kotlin-vim";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
