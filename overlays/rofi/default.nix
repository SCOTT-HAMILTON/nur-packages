self: super:
{
  rofi-unwrapped = super.rofi-unwrapped.overrideAttrs (old: {
    patches = (old.patches or []) ++ [ ./rofi.patch ];
  });
}
