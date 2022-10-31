{ lib
, stdenv
, fetchFromGitHub
, buildGo118Module
}:

buildGo118Module rec {
  pname = "smtprelay";
  version = "1.9.0";

  src = fetchFromGitHub {
    owner = "decke";
    repo = "smtprelay";
    rev = "v${version}";
    sha256 = "sha256-wC1PatVDToNf1GqyATTxCZr9fCKqe/9PPAIw6JocL78=";
  };

  vendorSha256 = "sha256-mit4wM4WQJiGaKzEW5ZSaZoe/bRMtq16f5JPk6mRq1k=";

  meta = with lib; {
    description = "Simple command-line snippet manager, written in Go";
    homepage = "https://github.com/knqyf263/pet";
    license = licenses.mit;
    maintainers = with maintainers; [ kalbasit ];
  };
}
