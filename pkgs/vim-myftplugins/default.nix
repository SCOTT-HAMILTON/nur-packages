{ pkgs
, lib
, vimUtils
, buildVimPluginFrom2Nix ? vimUtils.buildVimPluginFrom2Nix
, stdenv
, fetchFromGitHub
, coreutils
}:
buildVimPluginFrom2Nix {
  pname = "vim-myftplugins";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "vimconfig";
    rev = "master";
    sha256 = "0f9fpgc16hscx73qf1yisf75bg07faqgkqp7g28jr8q5qbyzzmv4";
  };

  buildInputs = [ coreutils ];

  postPatch = ''
    find . -maxdepth 1 | egrep -v "^\./ftplugin$|^\.$" | xargs -n1 -L1 -r -I{} rm -rf {}
  '';

  meta = {
    description = "My vim ftplugins";
    license = lib.licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/vimconfig";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = stdenv.lib.platforms.linux;
  };
}
