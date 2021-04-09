self: super:
{
  tabbed = (super.tabbed.override {
    patches = [ ./keys.patch ];
  }).overrideAttrs (old: {
    name = "tabbed-20180310-patched";
    # src = super.fetchFromGitHub {
    #   owner = "SCOTT-HAMILTON";
    #   repo = "tabbed";
    #   rev = "40d71347cb42dbfc68f636ca68120e46c7d4d520";
    #   sha256 = "1vdmggb4dywkm2r8ghsr48spdi49gpzd7l76m6xwl4dd791gka6c";
    # };
    src = ~/GIT/src.tar.gz;
  });
}
