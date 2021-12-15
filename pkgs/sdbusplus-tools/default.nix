{ lib
, python3Packages
, fetchFromGitHub
, getopt
}:

python3Packages.buildPythonApplication rec {
  pname = "sdbusplus-tools";
  version = "2021-11-22";

  src = fetchFromGitHub {
    owner = "openbmc";
    repo = "sdbusplus";
    rev = "f0eb650e27103c90536c4bc4ab0b51d186de64a0";
    sha256 = "1vwx51spyvax31nd1aazvs9r88ki3fp5kjbvhnxchd91lqbbg65q";
  };

  sourceRoot = "source/tools";

  postPatch = ''
    substituteInPlace sdbus++-gen-meson \
      --replace '#!/usr/bin/env bash' '#!/bin/bash'
    patchShebangs sdbus++-gen-meson
  '';

  propagatedBuildInputs = with python3Packages; [
    Mako
    pyyaml
    inflection
    getopt
  ];

  meta = with lib; {
    description = "Tools provided by sdbusplus";
    license = licenses.asl20;
    homepage = "https://github.com/openbmc/sdbusplus";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
