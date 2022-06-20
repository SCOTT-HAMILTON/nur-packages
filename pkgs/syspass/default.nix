{ stdenv
, lib
, noDev ? false
, php
, phpPackages ? php.packages
, writeTextFile
, fetchurl
, fetchgit
, fetchhg
, fetchsvn
, fetchFromGitHub
, unzip
}:
let
  composerEnv = import ./composer-env.nix {
    inherit stdenv lib writeTextFile fetchurl unzip php phpPackages;
  };
  composerJson = ./composer.json;
  composerLock = ./composer.lock;
  patch = ./fix-base-app-paths.patch;
in
import ./php-packages.nix {
  inherit composerEnv noDev fetchurl fetchgit fetchhg fetchsvn;
  src = fetchFromGitHub {
    owner = "nuxsmin";
    repo = "sysPass";
    rev = "3.2.8";
    sha256 = "sha256-uHMxwGidzDGT5TngvYx1AtZJijTxhl95FbDay45n3y4=";
    postFetch = ''
      pushd "$out"
      rm -rf composer.json composer.lock
      cp ${composerJson} ./composer.json
      cp ${composerLock} ./composer.lock
      
      patch -p1 < ${patch}
      popd
    '';
  };
}
