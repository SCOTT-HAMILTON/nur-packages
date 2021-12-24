{ tabbed
, fetchFromGitHub
, libbsd
, zeromq
}:
(tabbed.override {
  patches = [ ./keys.patch ];
}).overrideAttrs (old: {
  name = "tabbed-20180310-patched";
  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "tabbed";
    rev = "cea0ecb0ea8b4bda8b0aacf6eefb48dade9853d9";
    sha256 = "1jjfkjlpc7ig71ppxg8a5amsshmsvg58dgdimr2pc5n13zcl4hxv";
  };
  buildInputs = (old.buildInputs or []) ++ [ libbsd zeromq ];
})
