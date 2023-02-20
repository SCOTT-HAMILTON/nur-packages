{ lib
, fetchFromGitHub
, fetchpatch
, python3
, shellPython
, python3Packages ? python3.pkgs
, util-linux
}:
python3Packages.buildPythonPackage rec {
  pname = "pyzo";
  version = "4.12.7";

  src = fetchFromGitHub {
    owner = "pyzo";
    repo = "pyzo";
    rev = "v${version}";
    sha256 = "sha256-Ma7p7xLdjAzOWNILJDj6DJy/Tskry8qM9fG78QAViZU=";
  };

  nativeBuildInputs = [ util-linux ];

  propagatedBuildInputs = with python3Packages; [
    pyside2
    packaging
  ];

  postInstall = let 
    sizeShell = "$\{s}x$\{s}";
  in ''
    logos=$(find "$out/lib/${python3.libPrefix}/site-packages" -name 'pyzologo*.png')
    for l in $logos; do
      s=$(echo $l | rev | cut -d'/' -f1 | rev | sed -E 's=pyzologo(.*)\..*=\1=g');
      install -Dm644 "$l" "$out/share/icons/hicolor/${sizeShell}/apps/pyzologo.png"
    done
    install -Dm644 "$out/lib/${python3.libPrefix}/site-packages/pyzo/resources/pyzo.desktop" "$out/share/applications/pyzo.desktop"
  '';

  makeWrapperArgs = [
    "--set" "PYZO_DEFAULT_SHELL_PYTHON_EXE" "${shellPython}/bin/python"
  ];

  doCheck = false;

  meta = with lib; {
    description = "Interactive editor for scientific Python";
    homepage = "https://pyzo.org/";
    license = licenses.bsd3;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
