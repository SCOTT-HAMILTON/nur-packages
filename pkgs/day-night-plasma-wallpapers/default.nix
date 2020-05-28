{ lib
, stdenv
, fetchFromGitHub
, dbus-python
, coreutils
}:
stdenv.mkDerivation rec {

  pname = "day-night-plasma-wallpapers";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "Day-night-plasma-wallpapers";
    rev = "master";
    sha256 = "0nfp8xlkj0zf5kyrhq009bshyf5aghaicz5i2ly949z8l8mbx97h";
  };

  propagatedBuildInputs = [ dbus-python ];

  installPhase = ''
    install -Dm 555 update-day-night-plasma-wallpapers.py $out/bin/update-day-night-plasma-wallpapers.py
    install -Dm 555 update-day-night-plasma-wallpapers.py $out/.config/autostart-scripts/update-day-night-plasma-wallpapers.py
  '';

  meta = {
    description = "KDE Plasma utility to automatically change to a night wallpaper when the sun is reaching sunset.";
    license = lib.licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/Day-night-plasma-wallpapers";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = stdenv.lib.platforms.linux;
  };
}
