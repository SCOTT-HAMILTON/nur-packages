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
    sha256 = "10zj8qk0mx6if0bx3qj6jj0pziv9lvkq19msbdmb4915lq285avd";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp -r * "$out"
    ln -s "$out/adb" "$out/bin"
  '';

  meta = with lib; {
    description = "android sdk platform-tools";
    license = licenses.mit;
    homepage = "https://developer.android.com/studio";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
