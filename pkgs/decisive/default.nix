{ lib
, buildVimPlugin
, fetchFromGitHub
, nix-gitignore
}:

buildVimPlugin {
  pname = "decisive-vim";
  version = "2024-06-15";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "decisive.nvim";
    rev = "53a1e1a715fd93ccb5d705181413f726b4276431";
    sha256 = "sha256-Zcn5kqdI2to+bhJ10FZmpCfN33OaK1HgiHc7D7cS0Tw=";
  };
  # src = nix-gitignore.gitignoreSource [ ] /home/scott/GIT/decisive.nvim;

  meta = with lib; {
    description = "Neovim plugin to assist work with CSV files";
    license = licenses.mit;
    homepage = "https://github.com/emmanueltouzery/decisive.nvim";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
