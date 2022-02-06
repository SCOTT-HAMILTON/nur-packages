{ lib
, buildVimPluginFrom2Nix
, fetchFromGitHub
, coreutils
}:

buildVimPluginFrom2Nix {
  pname = "vim-async";
  version = "2022-01-04";

  src = fetchFromGitHub {
    owner = "prabirshrestha";
    repo = "async.vim";
    rev = "f20569020d65bec3249222606c073c0943045b5e";
    sha256 = "0lff0v2vd06amcjirnpa4wc4l4nsbngcrdqcv34kszyqgzd7phka";
  };

  meta = with lib; {
    description = "Normalize async job control api for vim and neovim";
    license = licenses.mit;
    homepage = "https://github.com/prabirshrestha/async.vim";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
