{ pkgs
, lib
, fetchFromGitHub
, buildVimPluginFrom2Nix
, vim-async
, vim-lsp
, vim-asyncomplete
, vim-asyncomplete-lsp
}:
buildVimPluginFrom2Nix rec {
  pname = "vim-lsp-settings";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "mattn";
    repo = "vim-lsp-settings";
    rev = "v${version}";
    sha256 = "1wvvqjpngxh07v2ka0qjf56my6hrjqk1i7jwismy2cmfj0br60xn";
  };

  buildInputs =           [ vim-async vim-lsp vim-asyncomplete vim-asyncomplete-lsp ];
  propagatedBuildInputs = [ vim-async vim-lsp vim-asyncomplete vim-asyncomplete-lsp ];

  meta = {
    description = "Auto configurations for Language Server for vim-lsp";
    license = lib.licenses.mit;
    homepage = "https://github.com/mattn/vim-lsp-settings";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = lib.platforms.linux;
  };
}
