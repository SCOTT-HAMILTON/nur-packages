#!/bin/sh

export nixosVersion="$1"
echo "NIX_PATH: $NIX_PATH"
echo "Nixos Version: $nixosVersion"

nix-build --argstr nixosVersion "$nixosVersion" all-unbroken.nix --show-trace; \
  export NIX_BUILD_ERROR=$?
if [ $NIX_BUILD_ERROR -ne 0 ]; then
# Build errored, saving successful builds to the cache
nix-build --keep-going --argstr nixosVersion "$nixosVersion" \
		  all-unbroken.nix --show-trace | cachix push "${CACHIX_CACHE}"
exit $NIX_BUILD_ERROR
else
# Build passed 
nix eval --argstr nixosVersion "$nixosVersion" -f default.nix 'lib' --show-trace
nix eval --argstr nixosVersion "$nixosVersion" -f default.nix 'modules' --show-trace
nix eval --argstr nixosVersion "$nixosVersion" -f default.nix 'overlays' --show-trace
fi

