{ lib
, fetchFromGitHub
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "commix";
  version = "3.3";

  src = fetchFromGitHub {
    owner = "commixproject";
    repo = "commix";
    rev = "v${version}";
    sha256 = "1029pirwjy57rvgbw7a8csvvcjcrlndgp77i2ykw3k1fzl0v026v";
  };

  propagatedBuildInputs = with python3Packages; [ tornado_4 python-daemon ];

  doCheck = true;

  meta = with lib; {
    description = "Automated All-in-One OS Command Injection Exploitation Tool";
    license = licenses.gpl3Only;
    homepage = "https://commixproject.com/";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
