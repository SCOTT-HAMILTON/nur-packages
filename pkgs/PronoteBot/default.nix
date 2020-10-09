{ lib
, buildPythonPackage
, fetchFromGitHub 
, click
, geckodriver
, pybase64
, selenium
}:

buildPythonPackage rec {
  pname = "PronoteBot";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "PronoteBot";
    rev = "033435e327542869a8108127f961b9afdeacd87d";
    sha256 = "0syi7jblrlynj6vlpsrvng24xi5mh5cw35x1vj0iqxw9fgzwq4bh";
  };

  # src = ./src.tar.gz;

  propagatedBuildInputs = [
    click
    geckodriver
    pybase64
    selenium
  ];

  doCheck = false;

  meta = with lib; {
    description = "Pronote bot to open pronote or to open the physics and chemistry book at a specified page";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
