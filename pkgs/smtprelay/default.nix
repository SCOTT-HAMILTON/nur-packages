{ lib
, stdenv
, fetchFromGitHub
, buildGo118Module
}:

buildGo118Module rec {
  pname = "smtprelay";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "decke";
    repo = "smtprelay";
    rev = "v${version}";
    sha256 = "sha256-fao2x5n0LW0YkSu1vDahI45rMYBVoFubOx4M1C7FYu0=";
  };

  vendorSha256 = "sha256-AvegUk9YXFyePIdMFHZOZV4VdtlfXWhEU43PyOaQSGc=";

  meta = with lib; {
    description = "Simple command-line snippet manager, written in Go";
    homepage = "https://github.com/knqyf263/pet";
    license = licenses.mit;
    maintainers = with maintainers; [ kalbasit ];
  };
}
