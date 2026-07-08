{
  python3Packages,
  fetchFromGitHub,
  lib,
  # nix-gitignore,
}:
python3Packages.buildPythonPackage {
  pname = "typst-fillable";
  version = "2026-07-08";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "typst-fillable";
    rev = "f5b50cacc72aa08f870c21e470448bda4e1aa8ec";
    hash = "sha256-hc7qbPK3DqDooQPI3xHdt6m/Ldmt5vSe93NPzmvDE7Y=";
  };
  # src = nix-gitignore.gitignoreSource [] ~/GIT/typst-fillable;

  build-system = with python3Packages; [ hatchling ];

  dependencies = with python3Packages; [
    typst
    reportlab
    pypdf
    pydantic
  ];

  pythonImportsCheck = [ "typst_fillable" ];

  nativeCheckInputs = with python3Packages; [ pytestCheckHook ];

  meta = {
    description = "Create fillable PDF forms from Typst templates with interactive text fields, checkboxes, and radio buttons";
    homepage = "https://github.com/carpe-diem/typst-fillable";
    license = lib.licenses.mit;
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
  };
}
