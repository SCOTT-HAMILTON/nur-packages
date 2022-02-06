{ lib
, python3Packages
, ssh-python
, ssh2-python
, libssh2
}:

python3Packages.buildPythonPackage rec {
  pname = "parallel-ssh";
  version = "2.8.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "1aqpr2cjmqaz2qcymk780ys1svr4hk2dngg612c1z9bqsacjajdn";
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
