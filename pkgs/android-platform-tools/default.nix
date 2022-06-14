{ lib
, fetchzip
, stdenv
, autoPatchelfHook
}:
stdenv.mkDerivation rec {

  pname = "android-platform-tools";
  version = "latest";

  src = fetchzip {
    url = "https://dl.google.com/android/repository/platform-tools-latest-linux.zip";
    sha256 = "0wxxbcvw197irxjayxmlzzhr7fgjqf3ma5yxd6ci1gklp2m7l98z";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp -r * "$out"
    ln -s "$out/adb" "$out/bin"
    ln -s "$out/fastboot" "$out/bin"
  '';

  meta = with lib; {
    description = "android sdk platform-tools";
    license = licenses.mit;
    homepage = "https://developer.android.com/studio";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
