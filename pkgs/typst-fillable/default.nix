{
  python3Packages,
  fetchFromGitHub,
  lib,
}:
python3Packages.buildPythonPackage {
  pname = "typst-fillable";
  version = "2025-12-31";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "carpe-diem";
    repo = "typst-fillable";
    rev = "31407567df630d157607b394cd55cdba51012c12";
    hash = "sha256-VJi0LY0zF4+IO6r8JDNH6X89jv8m8VIBvIYqi9q47OM=";
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
