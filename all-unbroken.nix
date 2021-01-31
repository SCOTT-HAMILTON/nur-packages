let
  lib = (import <nixpkgs> {}).lib;
  shamilton =
   lib.filterAttrs (n: v: n != "lib" && n != "modules" && n != "overlays" && (! (builtins.hasAttr "broken" (v.meta)) || ! v.meta.broken )) (import ./. {});
in 
  (lib.attrValues shamilton)
