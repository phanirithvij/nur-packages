{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "orderedattrdict";
  version = "1.6.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "sanand0";
    repo = "orderedattrdict";
    rev = "v${version}";
    hash = "sha256-hScdxu6jylRqNJ+4mpcmt9OMAHzT2YbXGoILE/cLdCY=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  pythonImportsCheck = [
    "orderedattrdict"
  ];

  meta = {
    description = "An ordered Python dictionary with attribute-style access";
    homepage = "https://github.com/sanand0/orderedattrdict";
    license = lib.licenses.mit;
  };
}
