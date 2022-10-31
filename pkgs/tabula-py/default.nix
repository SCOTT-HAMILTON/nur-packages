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
  version = "2.5.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-1tw/bh1CDfmNKVLpBwnG//ZesoQY56F9fl30t92G0Zc=";
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
