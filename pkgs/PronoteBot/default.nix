{ lib
, buildPythonPackage
, fetchFromGitHub 
, click
, geckodriver
, pyautogui
, pybase64
, selenium
, wget
}:

buildPythonPackage rec {
  pname = "PronoteBot";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "PronoteBot";
    rev = "5edf4991ba67eb1ce39ad1b69e9edebd04227676";
    sha256 = "1a8v1xmlhzw1ngnm52646wad1fgi0pvnl06pcqh4h428cxq6g9nx";
  };

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
