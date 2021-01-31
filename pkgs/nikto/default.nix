{ lib
, stdenv
, fetchFromGitHub
, perlPackages
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "nikto";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "sullo";
    repo = "nikto";
    rev = "c83d0461edd75c02677dea53da2896644f35ecab";
    sha256 = "0vwq2zdxir67cn78ls11qf1smd54nppy266v7ajm5rqdc47q7fy2";
  };

  patches = [ ./NIKTODIR-nix-wrapper-fix.patch ];

  postPatch = ''
    substituteInPlace program/nikto.conf.default \
      --replace "# EXECDIR=/opt/nikto" "EXECDIR=$out/share" \
      --replace "LW_SSL_ENGINE=auto" "LW_SSL_ENGINE=SSLeay"
  '';

  nativeBuildInputs = [ makeWrapper ];

  propagatedBuildInputs = [ perlPackages.NetSSLeay ];

  buildInputs = [
    perlPackages.perl
  ];

  installPhase = ''
    runHook preInstall
    mkdir $out
    install -d "$out/share"
    cp -a program/* "$out/share"
    install -Dm 755 "program/nikto.pl" "$out/bin/nikto"
    install -Dm 644 program/nikto.conf.default "$out/etc/nikto.conf"
    install -Dm 644 documentation/nikto.1 "$out/share/man/man1/nikto.1"
    install -Dm 644 program/docs/nikto_manual.html "$out/share/doc/${pname}/manual.html"
    install -Dm 644 README.md "$out/share/doc/${pname}/README"
    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/nikto \
      --prefix PERL5LIB : $PERL5LIB
  '';

  meta = with lib; {
    description = "Compositor for X11";
    license = licenses.mit;
    homepage = "https://github.com/tryone144/compton";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
