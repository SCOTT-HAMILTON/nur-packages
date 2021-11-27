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
    description = "CLI utility to create graphs from CSV files";
    homepage = "https://github.com/mcastorina/graph-cli";
    license = licenses.gpl3Plus;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
