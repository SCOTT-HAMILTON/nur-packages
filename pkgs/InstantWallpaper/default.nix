{ lib
, stdenv
, fetchFromGitHub
, fetchurl
, InstantLOGO
, InstantConf
, InstantUtils
, Paperbash
, imagemagick
, nitrogen
}:
stdenv.mkDerivation rec {

  pname = "instantWALLPAPER";
  version = "unstable";

  srcs = [
    (fetchFromGitHub {
      owner = "instantOS";
      repo = "instantWALLPAPER";
      rev = "master";
      sha256 = "1ril747fiwg0lzz4slc9ndzy5an3mwnmqk6fk58pp09z5g2wjhla";
    }) 
    (fetchurl {
      url = "https://github.com/instantOS/instantOS/archive/master.tar.gz";
      sha256 = "0448djpqvq5firya213sri4z3b7gwv2240f8swk90c9zrlhms161";
    })
  ];

  sourceRoot = "source";
  
  postUnpack = ''
    ls -lh
  '';

  postPatch = ''
    substituteInPlace wall.sh \
      --replace /usr/share/backgrounds/readme.jpg ${InstantLOGO}/share/backgrounds/readme.jpg \
      --replace /usr/share/instantwallpaper/wallutils.sh wallutils.sh \
      --replace "iconf" "${InstantConf}/bin/iconf" \
      --replace "checkinternet" "${InstantUtils}/bin/checkinternet" \
      --replace "/usr/share/paperbash" "${Paperbash}/share/paperbash"
    substituteInPlace wallutils.sh \
      --replace "iconf" "${InstantConf}/bin/iconf" \
      --replace "identify" "${imagemagick}/bin/identify" \
      --replace "convert" "${imagemagick}/bin/convert" \
      --replace "-composite" "__tmp_placeholder" \
      --replace "composite" "${imagemagick}/bin/composite" \
      --replace "__tmp_placeholder" "-composite"
      # --replace "ifeh" "${InstantUtils}/bin/ifeh" \
  '';
  
  installPhase = ''
    install -Dm 555 wallutils.sh $out/share/instantwallpaper/wallutils.sh
    install -Dm 555 wall.sh $out/bin/instantwallpaper
  '';

  propagatedBuildInputs = [ InstantLOGO InstantConf Paperbash imagemagick nitrogen ];

  meta = with lib; {
    description = "Window manager of instantOS.";
    license = licenses.mit;
    homepage = "https://github.com/instantOS/instantWM";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
