{ lib
, buildPythonPackage
, fetchFromGitHub 
, click
, geckodriver
, pybase64
, selenium
, wget
}:

let
  mach-nix = import (builtins.fetchGit {
    url = "https://github.com/DavHau/mach-nix/";
    ref = "refs/tags/2.4.1";
  });
  pyautogui = mach-nix.buildPythonPackage "https://github.com/asweigart/pyautogui/tarball/a62027c63fde";
in
buildPythonPackage rec {
  pname = "PronoteBot";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "PronoteBot";
    rev = "7fe097545aba0fa71893e038365046f482447fc9";
    sha256 = "1b1knwzkh49109d1nm2di4qvnks6vfsblkhv1a88x1fvgn9vwslq";
  };

  # src = ./src.tar.gz;

  propagatedBuildInputs = [
    click
    geckodriver
    pyautogui
    pybase64
    selenium
    wget
  ];

  doCheck = false;

  meta = with lib; {
    description = "Pronote bot to open pronote or to open the physics and chemistry book at a specified page";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
