{
  lib,
  python3,
  fetchFromGitHub,
}:
# Copied from https://github.com/jpetrucciani/nix/blob/2304bf8492c166753df7e3bcef8a801c73f0582c/mods/python/misc.nix#L175
# Licensed MIT Copyright (c) 2023 Jacobi Petrucciani
python3.pkgs.buildPythonPackage (finalAttrs: {
  pname = "starred";
  version = "4.3.0-unstable-2026-06-07";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "maguowei";
    repo = "starred";
    rev = "1e2bb94f44c376e06f8515d7304404ef1c93d4ca";
    hash = "sha256-+sSly81YRI8hcQHeXNNoSS6Q4U0/Y4S0psisKh5IVW8=";
  };

  build-system = with python3.pkgs; [ hatchling ];

  propagatedBuildInputs = with python3.pkgs; [
    aiohttp
    click
    github3-py
    gql
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
})
