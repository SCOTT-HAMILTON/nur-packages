{ lib
, python3Packages
, fetchFromGitHub 
}:

python3Packages.buildPythonPackage rec {
  pname = "day-night-plasma-wallpapers";
  version = "2022-02-11";

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "Day-night-plasma-wallpapers";
    rev = "aae28f1267c5f6820719e87932b670233ed3bbfa";
    sha256 = "1w1m0jrfdzvmrbvn0c1adysqcnl6qbcahkfbxp9gv85cvy42hqdl";
  };

  propagatedBuildInputs = with python3Packages; [ dbus-next ];

  postInstall = ''
    mkdir -p "$out/.config/autostart-scripts"
    ln -s "$out/bin/update-day-night-plasma-wallpapers" "$out/.config/autostart-scripts/update-day-night-plasma-wallpapers"
  '';

  meta = with lib; {
    description = "KDE Plasma utility to automatically change to a night wallpaper when the sun is reaching sunset";
    license = licenses.mit;
    homepage = "https://github.com/SCOTT-HAMILTON/Day-night-plasma-wallpapers";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
