{ lib
, buildVimPluginFrom2Nix
, fetchFromGitHub
, coreutils
}:

buildVimPluginFrom2Nix {
  pname = "vim-asyncomplete-lsp";
  version = "2021-12-17";

  src = fetchFromGitHub {
    owner = "prabirshrestha";
    repo = "asyncomplete-lsp.vim";
    rev = "f6d6a6354ff279ba707c20292aef0dfaadc436a3";
    sha256 = "1y0wpq982nw0ibqhvcvb7md58jvadygkxc1ibg99zxw1kznfpla6";
  };

  meta = with lib; {
    description = "LSP source for asyncomplete.vim vim-lsp";
    license = licenses.mit;
    homepage = "https://github.com/prabirshrestha/asyncomplete-lsp.vim";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
