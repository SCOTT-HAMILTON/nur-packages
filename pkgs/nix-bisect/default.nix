{ lib
, fetchFromGitHub
, python3Packages
}:
let
  good-setup-py = ./setup.py;
in
python3Packages.buildPythonApplication rec {
  pname = "nix-bisect";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "timokau";
    repo = "nix-bisect";
    rev = "v${version}";
    sha256 = "0rg7ndwbn44kximipabfbvvv5jhgi6vs87r64wfs5by81iw0ivam";
  };

  postPatch = ''
    ls -lh
    cp ${good-setup-py} setup.py
  '';

  propagatedBuildInputs = with python3Packages; [
    appdirs
    numpy
    pexpect
  ];

  doCheck = false;

  meta = with lib; {
    description = "Bisect nix builds";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
