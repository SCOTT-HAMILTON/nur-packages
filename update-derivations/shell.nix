{ pkgs ? import <nixpkgs> {} }:
let
  customPython = pkgs.python38.buildEnv.override {
    extraLibs = with pkgs.python38Packages; [
      dateutil
      packaging
      requests
    ];
  };
in
with pkgs; mkShell {
  buildInputs = [
    customPython
    ripgrep
    rargs
    findutils
  ];
  shellHook = ''
    run(){
      find pkgs -name "default.nix"|rargs rg -l "fetchFromGitHub" {0}|rargs -j$(nproc --all) python update-derivations/update-github-drv.py ~/.config/passwords/github-updater-token {0} 
      # python update-derivations/update-github-drv.py ~/.config/passwords/github-updater-token pkgs/patched-alacritty/default.nix
    }
  '';
}

