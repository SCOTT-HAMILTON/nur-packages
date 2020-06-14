{ config, lib, pkgs, options,
home, modulesPath
}:

with lib;

let
  cfg = config.myvim;
  MyVimConfig = pkgs.callPackage (import ./../pkgs/MyVimConfig )
  { lib = lib; };
  MyVimFtplugins = pkgs.callPackage (import ./../pkgs/vim-myftplugins )
  { lib = lib; };
  vim-async = pkgs.callPackage (import ./../pkgs/vim-async )
  { lib = lib; 
    buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
  };
  vim-lsp = pkgs.callPackage (import ./../pkgs/vim-lsp )
  { lib = lib; 
    buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
    vim-async = vim-async;
  };
  vim-asyncomplete = pkgs.callPackage (import ./../pkgs/vim-asyncomplete )
  { lib = lib; 
    buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
  };
  vim-asyncomplete-lsp = pkgs.callPackage (import ./../pkgs/vim-asyncomplete-lsp )
  { lib = lib; 
    buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
  };
  vim-lsp-settings = pkgs.callPackage (import ./../pkgs/vim-lsp-settings )
  { lib = lib; 
    buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
    vim-async = vim-async;
    vim-lsp = vim-lsp;
    vim-asyncomplete = vim-asyncomplete;
    vim-asyncomplete-lsp = vim-asyncomplete-lsp;
  };
in {

  options.myvim = {
    enable = mkEnableOption "My vim config from https://github.com/SCOTT-HAMILTON/vimconfig";
  };
  config = mkIf cfg.enable (mkMerge ([
    {
      programs.vim.enable = true;
      programs.vim.extraConfig = builtins.readFile "${MyVimConfig}/vimrc";
      programs.vim.plugins = [
        MyVimFtplugins
        pkgs.vimPlugins.commentary
        pkgs.vimPlugins.vim-colorschemes
        pkgs.vimPlugins.vim-qml
        vim-lsp
        vim-lsp-settings
      ];
    }
  ]));
}
