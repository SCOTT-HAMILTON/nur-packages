{ lib
, python3Packages
, ssh-python
, ssh2-python
, libssh2
}:

python3Packages.buildPythonPackage rec {
  pname = "parallel-ssh";
  version = "2.10.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-i5JfQ5cqVJrgkKVfVXvrU6GWhWZtvrFmswQ9YfXrLbk=";
  };
  
  propagatedBuildInputs = with python3Packages; [
    gevent
    paramiko
    ssh-python
    ssh2-python
    libssh2
  ];
  
  doCheck = true;

  meta = with lib; {
    description = "Asynchronous parallel SSH client library";
    homepage = "https://parallel-ssh.org/";
    license = licenses.lgpl21Plus;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
