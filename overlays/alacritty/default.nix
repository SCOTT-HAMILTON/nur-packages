self: super:
{
  alacritty = super.alacritty.overrideAttrs (old: {
    postPatch = ''
      sed -Ei 's/^Exec=alacritty/Exec=tabbed -cr 2 alacritty --embed ""/g' "extra/linux/Alacritty.desktop"
    '';
    propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [ super.tabbed ];
  });
}
