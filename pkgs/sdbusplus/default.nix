{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, systemd
, boost
, gtest
, sdbusplus-tools
, breakpointHook
}:

stdenv.mkDerivation {
  pname = "sdbusplus";
  version = "2021-11-22";

  src = fetchFromGitHub {
    owner = "openbmc";
    repo = "sdbusplus";
    rev = "f0eb650e27103c90536c4bc4ab0b51d186de64a0";
    sha256 = "1vwx51spyvax31nd1aazvs9r88ki3fp5kjbvhnxchd91lqbbg65q";
  };

  patches = [ /tmp/good.patch ];

  postPatch = ''
    find . -executable -type f \( ! -iname "setup.py" \) -exec rm {} \;
  '';

  nativeBuildInputs = [ sdbusplus-tools pkg-config ninja meson breakpointHook ];
  buildInputs = [ gtest systemd boost ];
  propagatedBuildInputs = [
    sdbusplus-tools
  ];

  meta = with lib; {
    description = "C++ bindings for systemd dbus APIs";
    license = licenses.asl20;
    homepage = "https://github.com/openbmc/sdbusplus";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
