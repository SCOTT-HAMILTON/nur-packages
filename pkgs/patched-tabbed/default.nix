{ tabbed
, fetchFromGitHub
, libbsd
}:
(tabbed.override {
  patches = [ ./keys.patch ];
}).overrideAttrs (old: {
  name = "tabbed-20180310-patched";
  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "tabbed";
    rev = "802d64832595c77ac2a36e8ef28eada82ae6fa7b";
    sha256 = "09h6y8s4r2mdm01vshnbrdyy4xi7bbvdwzpmv9b10y82mgsvx0n8";
  };
  buildInputs = (old.buildInputs or []) ++ [ libbsd ];
})
