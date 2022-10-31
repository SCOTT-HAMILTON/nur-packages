{ lib
, python38Packages
, fetchFromGitHub
, zlib
, openssl
, libssh
, openssh
, git
, octoprint
}:

python38Packages.buildPythonPackage rec {
  pname = "ssh-python";
  version = "03.0";

  disabled = python38Packages.pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ParallelSSH";
    repo = "ssh-python";
    rev = version;
    sha256 = "sha256-Nlp/bv9VtIUbp8r6RkVpOgRAJvCPLyJjmRIpR8vw2WQ=";
    leaveDotGit = true;
    deepClone = true;
  };

  postPatch = ''
    substituteInPlace tests/embedded_server/openssh.py \
      --replace '/usr/sbin/sshd' '${openssh}/bin/sshd'
  '';

  SYSTEM_LIBSSH = 1;

  nativeBuildInputs = [ git ];
  buildInputs = [ zlib openssl libssh ];
  checkInputs = [ octoprint python38Packages.pytest ];

  patches = [ ./fix-fix_version-script.patch ];

  preConfigure = ''
    python ci/appveyor/fix_version.py . ${version}
  '';

  doCheck = false;

  meta = with lib; {
    description = "Bindings for libssh C library";
    homepage = "https://github.com/ParallelSSH/ssh-python";
    license = licenses.lgpl21Plus;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
