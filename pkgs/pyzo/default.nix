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
  version = "4.12.3";

  src = fetchFromGitHub {
    owner = "pyzo";
    repo = "pyzo";
    rev = "v${version}";
    sha256 = "sha256-wr7r70b+eHnjAzwGJDXdU1dumA8s9X61UD+5Jcp92Ww=";
  };

  patches = [ (fetchpatch {
    url = "https://github.com/pyzo/pyzo/pull/819/commits/75e81f350b8df3ce3f9de190060a00b045c9b7f0.patch";
    sha256 = "sha256-+cwSLtr48wxs+TiHyvYNrcvOQkmOXhM0Hz3yeOaa794=";
  }) ];

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
