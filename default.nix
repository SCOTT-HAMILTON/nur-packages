{ pkgs ? import <nixpkgs> {}
, localUsage ? false
, nixosVersion ? "master"
}:
let
  lib = pkgs.lib;
  python_with_openpyxl305 = pkgs.python38.override {
    packageOverrides = self: super: {
      openpyxl = pkgs.python38Packages.openpyxl.overrideAttrs (old: {
        version = "3.0.5";
        src = pkgs.python38Packages.fetchPypi {
          pname = "openpyxl";
          version = "3.0.5";
          sha256 = "06y7lbqnn0ga2x55az4hkqfs202fl6mkv3m5h0js2a01cnd1zq8q";
        };
      });
    };
  };
  kdeApplications = if nixosVersion == "master" then pkgs.kdeApplications else pkgs.libsForQt5.kdeApplications;
in
pkgs.lib.traceValFn (x:
 "Nixpkgs version : ${pkgs.lib.version},
  Nixos Version : ${nixosVersion},
  Local Usage : ${if localUsage then "true" else "false"}"
)
(lib.makeExtensible (self:
{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules

  android-platform-tools = pkgs.callPackage ./pkgs/android-platform-tools { };
  anystyle-cli = pkgs.callPackage ./pkgs/anystyle-cli { };
  argparse = pkgs.callPackage ./pkgs/argparse { };
  baobab = pkgs.callPackage ./pkgs/baobab { };
  boca = pkgs.callPackage ./pkgs/boca { inherit (self) smooth; };
  bomber = kdeApplications.callPackage ./pkgs/Bomber { };
  cargo-sort-ck = with pkgs.rustPlatform; pkgs.callPackage ./pkgs/cargo-sort-ck {
    inherit buildRustPackage;
  };
  cdc-cognitoform-result-generator = pkgs.callPackage ./pkgs/CdC-cognitoform-result-generator {
    inherit (pkgs.python3Packages) buildPythonApplication pandas click setuptools;
  };
  # chart-cli = pkgs.haskellPackages.callPackage ./pkgs/chart-cli { };
  commix = with pkgs.python37Packages; pkgs.callPackage ./pkgs/commix {
    inherit buildPythonApplication;
  };
  compton = pkgs.callPackage ./pkgs/Compton { };
  controls-for-fake = pkgs.libsForQt5.callPackage ./pkgs/ControlsForFake  {
    inherit (self) libfake;
    FakeMicWavPlayer = self.fake-mic-wav-player;
  };
  # create_ap = pkgs.callPackage ./pkgs/create_ap { };
  # csview = with pkgs.rustPlatform; pkgs.callPackage ./pkgs/csview {
  #   inherit buildRustPackage;
  # };
  day-night-plasma-wallpapers = with pkgs.python3Packages; pkgs.callPackage ./pkgs/day-night-plasma-wallpapers { 
    dbus-python = dbus-python;
  };
  fake-mic-wav-player = pkgs.libsForQt5.callPackage ./pkgs/FakeMicWavPlayer {
    inherit (self) libfake argparse;
  };
  freac = pkgs.callPackage ./pkgs/freac { inherit (self) boca smooth; };
  # geogebra = pkgs.callPackage ./pkgs/geogebra { };
  # graph-cli = with pkgs; python3Packages.callPackage ./pkgs/graph-cli {
  #   inherit (python3Packages) buildPythonPackage fetchPypi matplotlib pandas;
  # };
  haste-client = pkgs.callPackage ./pkgs/haste-client { };
  inkscape = pkgs.callPackage ./pkgs/inkscape-1.0 { 
    lcms = pkgs.lcms2;
  };
  instanttee = with pkgs.rustPlatform; pkgs.callPackage ./pkgs/InstantTee {
    inherit buildRustPackage;
  };
  iptux = with pkgs; callPackage ./pkgs/iptux {
    inherit (gst_all_1) gstreamer;
    inherit (gnome2) gtk;
  };
  json-beautifier = pkgs.callPackage ./pkgs/json-beautifier { };
  juk = kdeApplications.callPackage ./pkgs/Juk { };
  kapptemplate = kdeApplications.callPackage ./pkgs/KAppTemplate { };
  kbreakout = kdeApplications.callPackage ./pkgs/KBreakOut { };
  keysmith = kdeApplications.callPackage ./pkgs/keysmith { };
  killbots = kdeApplications.callPackage ./pkgs/Killbots { };
  kirigami-gallery = kdeApplications.callPackage ./pkgs/KirigamiGallery { };
  ksmoothdock = pkgs.libsForQt5.callPackage ./pkgs/ksmoothdock { };
  # lerna = pkgs.callPackage ./pkgs/lerna { };
  libfake = pkgs.callPackage ./pkgs/FakeLib { };
  lokalize = pkgs.libsForQt5.callPackage ./pkgs/Lokalize { };
  merge-keepass = with pkgs.python3Packages; pkgs.callPackage ./pkgs/merge-keepass { 
    inherit buildPythonPackage pykeepass click pytest;
  };
  mermaid-cli = pkgs.callPackage ./pkgs/mermaid-cli {
    inherit (pkgs.nix-gitignore) gitignoreSource;
  };
  mouseinfo = with pkgs.python38Packages; pkgs.callPackage ./pkgs/mouseinfo {
    inherit (self) python3-xlib;
    inherit buildPythonPackage fetchPypi pyperclip pillow;
  };
  ncgopher = pkgs.callPackage ./pkgs/ncgopher { };
  nikto = pkgs.callPackage ./pkgs/nikto { };
  numworks-udev-rules = pkgs.callPackage ./pkgs/numworks-udev-rules { };
  parallel-ssh = with pkgs.python3Packages; pkgs.callPackage ./pkgs/parallel-ssh {
    inherit (self) ssh2-python;
    inherit buildPythonPackage setuptools fetchPypi paramiko gevent;
  };
  pdf2timetable = pkgs.callPackage ./pkgs/Pdf2TimeTable {
    inherit (python_with_openpyxl305.pkgs) buildPythonPackage numpy openpyxl pandas pypdf2 click;
    inherit (self) tabula-py;
  };
  pronotebot = with pkgs.python3Packages; pkgs.callPackage ./pkgs/PronoteBot {
    inherit (self) pyautogui;
    inherit buildPythonPackage pybase64 selenium click;
    inherit (pkgs.python3Packages) wget;
  };
  pronote-timetable-fetch = pkgs.callPackage ./pkgs/pronote-timetable-fetch {
  };
  ptouch-print = pkgs.callPackage ./pkgs/ptouch-print { };
  pyautogui = with pkgs.python3Packages; pkgs.callPackage ./pkgs/pyautogui {
    inherit (self)
      mouseinfo
      pygetwindow
      pyrect
      pyscreeze
      python3-xlib
      pytweening;
    inherit
      buildPythonPackage
      fetchPypi
      pymsgbox;
  };
  pygetwindow = with pkgs.python3Packages; pkgs.callPackage ./pkgs/pygetwindow {
    inherit (self) pyrect;
    inherit buildPythonPackage fetchPypi;
  };
  python-iconf = with pkgs.python3Packages; pkgs.callPackage ./pkgs/python-iconf {
    inherit buildPythonPackage fetchPypi pytest;
  };
  # python-keepassx = with pkgs.python3Packages; pkgs.callPackage ./pkgs/python-keepassx {
  #   inherit buildPythonPackage
  #           prettytable
  #           pycrypto
  #           pyyaml
  #           six
  #           mock
  #           pytest
  #           pytest-cov
  #           twine;
  # };
  python3-xlib = with pkgs.python3Packages; pkgs.callPackage ./pkgs/python3-xlib {
    inherit buildPythonPackage fetchPypi;
  };
  pyrect = with pkgs.python3Packages; pkgs.callPackage ./pkgs/pyrect {
    inherit buildPythonPackage fetchPypi;
  };
  pyscreeze = with pkgs.python3Packages; pkgs.callPackage ./pkgs/pyscreeze {
    inherit buildPythonPackage fetchPypi pillow;
  };
  pytweening = with pkgs.python3Packages; pkgs.callPackage ./pkgs/pytweening {
    inherit buildPythonPackage;
  };
  # qradiopredict = pkgs.libsForQt5.callPackage ./pkgs/qradiopredict { };
  qtile = pkgs.callPackage ./pkgs/qtile { };
  # remark-lint = pkgs.callPackage ./pkgs/remark-lint { };
  rustscan = pkgs.callPackage ./pkgs/rustscan { };
  semantik = pkgs.libsForQt5.callPackage ./pkgs/semantik { };
  scripts = with pkgs.python3Packages; pkgs.callPackage ./pkgs/Scripts {
    eom = pkgs.mate.eom;
    inherit (self) parallel-ssh sync-database merge-keepass;
    inherit buildPythonPackage;
  };
  slick-greeter = with pkgs.gnome3; pkgs.callPackage ./pkgs/slick-greeter {
    inherit gnome-common gtk slick-greeter;
  };
  smooth = with pkgs.gnome3; pkgs.callPackage ./pkgs/smooth { inherit gtk; };
  spectacle-clipboard = pkgs.libsForQt5.callPackage ./pkgs/spectacle-clipboard { };
  splat = pkgs.callPackage ./pkgs/splat { };
  ssh2-python = with pkgs.python3Packages; pkgs.callPackage ./pkgs/ssh2-python {
    inherit buildPythonPackage fetchPypi cython setuptools pytest;
  };
  super-tux-kart = pkgs.callPackage ./pkgs/SuperTuxKart {
    inherit (self) wiiuse;
  };
  sync-database = with pkgs.python3Packages; pkgs.callPackage ./pkgs/sync-database {
    inherit (self) parallel-ssh merge-keepass;
    inherit buildPythonPackage pykeepass;
  };
  tabula-py = pkgs.callPackage ./pkgs/tabula-py {
    inherit (python_with_openpyxl305.pkgs) buildPythonPackage fetchPypi distro numpy pandas setuptools_scm setuptools;
  };
  timetable2header = with pkgs.python3Packages; pkgs.callPackage ./pkgs/TimeTable2Header {
    inherit buildPythonPackage click pandas numpy odfpy;
  };
  unoconvui = pkgs.libsForQt5.callPackage ./pkgs/UnoconvUI  { };
  # voacap = pkgs.callPackage ./pkgs/voacap { };
  vokoscreen-ng = with pkgs; libsForQt5.callPackage ./pkgs/vokoscreenNG {
    gstreamer = gst_all_1.gstreamer;
    gst-plugins-base = gst_all_1.gst-plugins-base;
    gst-plugins-good = gst_all_1.gst-plugins-good;
    gst-plugins-bad = gst_all_1.gst-plugins-bad;
    gst-plugins-ugly = gst_all_1.gst-plugins-ugly;
  };
  wavetrace = with pkgs; python3Packages.callPackage ./pkgs/Wavetrace {
    inherit (self) splat;
    inherit (python3Packages)
      buildPythonPackage
      certifi
      chardet
      click
      gdal
      idna
      requests
      shapely
      urllib3;
  };
  wiiuse = pkgs.callPackage ./pkgs/WiiUse { };
  yaml2probatree = with pkgs.python3Packages; pkgs.callPackage ./pkgs/Yaml2ProbaTree {
    inherit buildPythonPackage pyyaml click;
  };
} // 
# Override derivations (patches),
# I put them here so that they get evaluated
# by the CI, it's also convenient to be able
# to access them directly from the root repo
{
  patched-alacritty = with pkgs; import ./pkgs/patched-alacritty {
    inherit lib stdenvNoCC fetchFromGitHub alacritty writeScriptBin nixosVersion;
  };
  patched-tabbed = with pkgs; import ./pkgs/patched-tabbed {
    inherit tabbed fetchFromGitHub libbsd;
  };
} //
# Derivations not supported on NUR
pkgs.lib.optionalAttrs (localUsage) (rec {
  mvn2nix = pkgs.callPackage ./pkgs/mvn2nix { };
  xtreme-download-manager = pkgs.callPackage ./pkgs/xtreme-download-manager {
    inherit mvn2nix localUsage;
  };
})
)).extend (self: super: {
  overlays = import ./overlays { selfnur = self; }; # nixpkgs overlays
})
