{ lib
, fetchFromGitHub
, fetchpatch
, python3
, python3Packages ? python3.pkgs
}:
python3Packages.buildPythonPackage rec {
  pname = "youtube-dl";
  version = "2023-03-09";

  src = fetchFromGitHub {
    owner = "ytdl-org";
    repo = "youtube-dl";
    rev = "8c86fd33dca48ebb505ed04150d9e35993b9fe7e";
    sha256 = "sha256-x8wEWH06vm1db5I8ovkcJPa3OVRssLcq1+p/k9eZzlw=";
  };

  doCheck = false;

  meta = with lib; {
    description = "Command-line program to download videos from YouTube.com";
    homepage = "http://ytdl-org.github.io/youtube-dl/";
    license = licenses.unlicense;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
