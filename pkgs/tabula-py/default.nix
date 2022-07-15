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
  version = "2.4.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-01VIo25OKiZdZW/5M4DZWybInatuXo1hCcaUonytYjo=";
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
    homepage = "https://github.com/chezou/tabula-py";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
