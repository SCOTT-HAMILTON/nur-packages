{ lib
, python3Packages
, cmake
, openssl
, zlib
}:
python3Packages.buildPythonPackage rec {
  pname = "ssh2-python";
  version = "0.27.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "0fv216a2nz8divgm1b3dww3is36k8kk0vbvh1klmr85p8kzi8nx6";
  };
  
  nativeBuildInputs = with python3Packages; [ cmake setuptools ];
  buildInputs = [ openssl zlib ];
  propagatedBuildInputs = with python3Packages; [ cython ];
  cmakeDir = "../libssh2";

  checkInputs = with python3Packages; [ pytest ];

  preBuild = ''
    cd ..
  '';

  doCheck = true;

  meta = with lib; {
    description = "Super fast SSH2 protocol library";
    homepage = "https://github.com/ParallelSSH/ssh2-python";
    license = licenses.lgpl2;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
