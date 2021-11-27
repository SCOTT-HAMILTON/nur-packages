{ lib
, fetchFromGitHub
, python3Packages
, python3-xlib
}:

python3Packages.buildPythonApplication rec {
  pname = "MouseInfo";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "asweigart";
    repo = "mouseinfo";
    rev = "27d4059a20180344bbfaed4b679f193d44c9f366";
    sha256 = "1ylnsr5ffh7lb4yr5m79jcnfkdyz79yq06r21ccd1yqdnmaf7p4w";
  };

  propagatedBuildInputs = with python3Packages; [
    pillow
    pyperclip
    python3-xlib
    setuptools
  ];

  doCheck = false;

  meta = with lib; {
    description = "Displays XY position and RGB color under the mouse";
    homepage = "https://github.com/asweigart/mouseinfo";
    license = licenses.gpl3;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
