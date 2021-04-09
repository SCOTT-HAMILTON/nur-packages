self: super:
let
  tabbed-alacritty = super.writeScriptBin "tabbed-alacritty"
  ''
    #!${super.stdenv.shell}
    tabbed -cr 2 -w "--working-directory" -x "--xembed-tcp-port" alacritty --embed ""
  '';
in
{
  alacritty = super.alacritty.overrideAttrs (old: rec {
    pname = "${old.pname}-patched";
    src = super.fetchFromGitHub {
      owner = "SCOTT-HAMILTON";
      repo = "alacritty";
      rev = "230f9207e38282814cc2f463eaf726dff9d45788";
      sha256 = "0xdnli6y6pjapskb00bwsmzdhvk69pljzi81agcsipgqgd1nxk04";
    };
    postPatch = ''
      sed -Ei 's|^Exec=alacritty|Exec=${tabbed-alacritty}/bin/tabbed-alacritty|g' "extra/linux/Alacritty.desktop"
    '';
    propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [ tabbed-alacritty ];
    doCheck = false;
    cargoDeps = old.cargoDeps.overrideAttrs (super.lib.const {
      inherit src;
      outputHash = "0nbj4gw0qpv6l11rr2mf3sdz9a2qkgp7cfj9g7zkzzg4b53d9s6x";
      doCheck = false;
    });
  });
}
