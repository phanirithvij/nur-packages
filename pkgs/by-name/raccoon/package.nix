{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "raccoon";
  version = "0-unstable-2023-08-23";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rsheftel";
    repo = "raccoon";
    rev = "73dc8f40588591c2fce951e7327a7d0fc79d5e4f";
    hash = "sha256-uellxqnOBSDAWoKm9HM2cexggn3gnRQ2VKriBqwQF2k=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  dependencies = [
    python3.pkgs.tabulate
  ];

  optional-dependencies = {
    test = [
      python3.pkgs.pytest
    ];
  };

  pythonImportsCheck = [
    "raccoon"
  ];

  meta = {
    description = "Python DataFrame with fast insert and appends";
    homepage = "https://github.com/rsheftel/raccoon";
    license = lib.licenses.mit;
  };
}
