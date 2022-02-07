{pkgs ? import <nixpkgs> {}, localUsage ? false, nixosVersion ? "master"} @ args:
let
  lib = pkgs.lib;
  shamilton = import ./. args;
in 
lib.attrValues shamilton.tests
