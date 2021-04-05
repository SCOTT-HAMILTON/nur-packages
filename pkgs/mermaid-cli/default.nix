{ pkgs
, nodejs
, stdenv
, lib
, makeWrapper
, fetchFromGitHub
, gitignoreSource
, chromium
}:

let
  nodePackages = import ./node-composition.nix {
    inherit pkgs nodejs gitignoreSource;
    inherit (stdenv.hostPlatform) system;
  };
in
nodePackages.package.override {
  name = "mermaid-cli";

  nativeBuildInputs = [ makeWrapper ];

  preInstallPhases = "skipChromiumDownload";
  skipChromiumDownload = ''
    export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
  '';

  postFixup = ''
     wrapProgram $out/bin/mmdc \
         --set PUPPETEER_EXECUTABLE_PATH ${chromium.outPath}/bin/chromium
  '';
  meta = with lib; {
    description = "The commitizen command line utility";
    homepage = "https://commitizen.github.io/cz-cli";
    maintainers = with maintainers; [ shamilton ];
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
