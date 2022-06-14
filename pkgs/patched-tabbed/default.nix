{ tabbed
, fetchFromGitHub
, libbsd
, zeromq
, nix-gitignore
}:
(tabbed.override {
  patches = [ ./keys.patch ];
}).overrideAttrs (old: {
  name = "tabbed-20180310-patched";
  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "tabbed";
    rev = "2dd66f0ab17e8fb97592179c3c65eac54d3f1f87";
    sha256 = "0q7fk4sq3kx5k9nkamq086c5rc8h0vkb0p0gyig5m9dqfxbkp63x";
  };
  # src = nix-gitignore.gitignoreSource [ ] ~/GIT/tabbed;
  buildInputs = (old.buildInputs or []) ++ [ libbsd zeromq ];
  # dontStrip = true;
})
