# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> {} }:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  baobab = pkgs.callPackage ./pkgs/baobab { };
  bomber = pkgs.kdeApplications.callPackage ./pkgs/Bomber { };
  controls-for-fake = pkgs.libsForQt5.callPackage ./pkgs/ControlsForFake  {
    FakeMicWavPlayer = fake-mic-wav-player;
  };
  day-night-plasma-wallpapers = pkgs.callPackage ./pkgs/day-night-plasma-wallpapers { 
    dbus-python = pkgs.python3Packages.dbus-python;
  };
  fake-mic-wav-player = pkgs.libsForQt5.callPackage ./pkgs/FakeMicWavPlayer { };
  inkscape = pkgs.callPackage ./pkgs/inkscape-1.0 { 
    lcms = pkgs.lcms2;
  };
  kapptemplate = pkgs.kdeApplications.callPackage ./pkgs/KAppTemplate { };
  kbreakout = pkgs.kdeApplications.callPackage ./pkgs/KBreakOut { };
  keysmith = pkgs.kdeApplications.callPackage ./pkgs/keysmith { };
  killbots = pkgs.kdeApplications.callPackage ./pkgs/Killbots { };
  kirigami-gallery = pkgs.kdeApplications.callPackage ./pkgs/KirigamiGallery { };
  ksmoothdock = pkgs.libsForQt5.callPackage ./pkgs/ksmoothdock { };
  lokalize = pkgs.libsForQt5.callPackage ./pkgs/Lokalize { };
  scripts = pkgs.callPackage ./pkgs/Scripts {
    eom = pkgs.mate.eom;
  };
  spectacle-clipboard = pkgs.libsForQt5.callPackage ./pkgs/spectacle-clipboard { };

}

