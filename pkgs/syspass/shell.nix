{ pkgs ? import <nixpkgs> {} }:
let
  myphp = pkgs.php74.withExtensions ({ enabled, all }:
  enabled ++ [
    all.curl
    all.gd
    all.mbstring
    all.intl
    all.readline
    all.ldap
  ]);
in
pkgs.mkShell {
  buildInputs = [ myphp myphp.packages.composer ];
  shellHook = ''
  '';
}

