{
  lib,
  python3,
  fetchFromGitHub,
}:
# Copied from https://github.com/jpetrucciani/nix/blob/2304bf8492c166753df7e3bcef8a801c73f0582c/mods/python/misc.nix#L175
# Licensed MIT Copyright (c) 2023 Jacobi Petrucciani
python3.pkgs.buildPythonPackage rec {
  pname = "starred";
  version = "4.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "maguowei";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ugseXFiDQXLCg9wImpLCPmRJp31/OI8VuxxYD4JJ8mg=";
  };

  build-system = with python3.pkgs; [ setuptools ];

  propagatedBuildInputs = with python3.pkgs; [
    aiohttp
    click
    github3-py
    gql
    poetry-core
    requests
  ];

  pythonCheckImports = [
    "starred"
  ];

  pythonRelaxDeps = true;

  meta = {
    description = "Create your own Awesome List by GitHub stars";
    homepage = "https://github.com/maguowei/starred";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ phanirithvij ];
  };
}
