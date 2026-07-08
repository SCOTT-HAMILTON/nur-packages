{
  python3Packages,
  fetchFromGitHub,
  lib,
}:
python3Packages.buildPythonPackage {
  pname = "typst-fillable";
  version = "2026-07-08";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "SCOTT-HAMILTON";
    repo = "typst-fillable";
    rev = "20f73a30d0061bae7c2a618520a6df1896e965e8";
    hash = "sha256-HdrecFYxmMCG5NdqX2tVN2TLUFllVm2SkxyUXFtk0Uk=";
  };

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
