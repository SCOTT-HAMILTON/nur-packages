{ lib
, fetchFromGitHub
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "commix";
  version = "3.5";

  src = fetchFromGitHub {
    owner = "commixproject";
    repo = "commix";
    rev = "v${version}";
    sha256 = "sha256-3UCHTgIW7ArXQD0Kj5XwE1I5VszsueXDJ68QWdQrAho=";
  };

  propagatedBuildInputs = with python3Packages; [ tornado python-daemon ];

  doCheck = true;

  meta = with lib; {
    description = "Automated All-in-One OS Command Injection Exploitation Tool";
    license = licenses.gpl3Only;
    homepage = "https://commixproject.com/";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
