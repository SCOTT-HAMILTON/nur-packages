{ lib
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname = "graph-cli";
  version = "0.1.17";

  src = python3Packages.fetchPypi {
    inherit version;
    pname = "graph_cli";
    sha256 = "1ccqhlwb3hrsx794fyhyhfblxqg33di8b5pmqj6jj8mpbb366d3c";
  };
  
  propagatedBuildInputs = with python3Packages; [ matplotlib pandas ];

  doCheck = true;

  meta = with lib; {
    description = "Rtree: spatial index for Python GIS";
    homepage = "https://rtree.readthedocs.io/en/latest/";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
