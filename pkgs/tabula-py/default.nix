{ lib
, buildPythonPackage
, fetchPypi
, distro
, numpy
, pandas
, setuptools_scm
, setuptools
}:

buildPythonPackage rec {
  pname = "tabula-py";
  version = "2.3.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0jf16wpn37xz8dn5c5h1396i0k3djl4zplb4zbkpjvr5sjjim9lx";
  };
  
  propagatedBuildInputs = [
    distro
    numpy
    pandas
    setuptools_scm
    setuptools
  ];

  doCheck = true;

  meta = with lib; {
    description = "Simple wrapper for tabula-java, read tables from PDF into DataFrame";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
