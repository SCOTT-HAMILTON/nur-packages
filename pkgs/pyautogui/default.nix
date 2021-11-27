{ lib
, python3Packages
, mouseinfo
, python3-xlib
, pygetwindow
, pyrect
, pyscreeze
, pytweening
}:

python3Packages.buildPythonPackage rec {
  pname = "PyAutoGUI";
  version = "0.9.53";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0dbhr4pbnwzxkbmi9j70js8kwam1w7y93069gyz913912bvyh7fk";
  };

  propagatedBuildInputs = with python3Packages; [
    pyrect
    mouseinfo
    pygetwindow
    pymsgbox
    pyscreeze
    python3-xlib
    pytweening
  ];

  doCheck = false;

  meta = with lib; {
    description = ''GUI automation Python module for human beings'';
    homepage = "https://github.com/asweigart/pyautogui";
    license = licenses.bsd3;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
