{ lib
, stdenv
, fetchFromGitHub
, eom
, surf
, zathura
}:
stdenv.mkDerivation rec {

  pname = "Scripts";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "Scripts";
    rev = "master";
    sha256 = "05hqxqpxs5bnm51vqm1m7w1bj8fc1xwafcj88q1j7358q7nxbyrb";
  };

  propagatedBuildInputs = [ eom surf zathura ];

  installPhase = ''
    install -Dm 555 open-documentation.py $out/bin/open-documentation.py
  '';

  meta = with lib; {
    description = "Scripts to make my life easier";
    license = licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/Scripts";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
