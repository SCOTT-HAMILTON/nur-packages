{ lib
, buildVimPluginFrom2Nix
, fetchFromGitHub
}:

buildVimPluginFrom2Nix {
  pname = "kotlin-vim";
  version = "2022-06-27";

  src = fetchFromGitHub {
    owner = "udalov";
    repo = "kotlin-vim";
    rev = "1261f851e5fb2192b3a5e1691650597c71dfce2f";
    sha256 = "sha256-zfSDbd9NcSkAAZP1vwZ/Zv+DwiOxxNV42c7z11lDxVM=";
  };

  meta = with lib; {
    description = "Kotlin plugin for Vim";
    license = licenses.asl20;
    homepage = "https://github.com/udalov/kotlin-vim";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
