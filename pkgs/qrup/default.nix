{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "qrup";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "qrup";
    rev = "c296a61c90dddacceb2c5019c0016c9083eee0fb";
    sha256 = "0frw7nnhyizljbwmcylqlxy6ghcxx83h88x036qcnwjjd0yjghg2";
  };

  cargoSha256 = "0ig2vl5xg40jjzvc4glmxhl9j7fryhyc9ikj0qz6w4vag39lj8i2";
  verifyCargoDeps = true;

  meta = with lib; {
    description = "Transfer files over LAN from your mobile device to your computer.";
    homepage = "https://github.com/SCOTT-HAMILTON/qrup";
    license = licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
