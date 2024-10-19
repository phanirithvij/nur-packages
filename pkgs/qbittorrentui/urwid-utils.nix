{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "urwid-utils";
  version = "0.1.3.dev0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tonycpsu";
    repo = "urwid_utils";
    rev = "v${version}";
    hash = "sha256-0tdWf22nDiFNZChmH8ibvfsVUONJ0p4KqmUlnr99EbE=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  dependencies = [ python3.pkgs.urwid ];

  pythonImportsCheck = [
    "urwid_utils"
  ];

  meta = {
    description = "A collection of simple, straightforward, but extensible utilities for the urwid package";
    homepage = "https://github.com/tonycpsu/urwid_utils";
    license = lib.licenses.mit;
  };
}
