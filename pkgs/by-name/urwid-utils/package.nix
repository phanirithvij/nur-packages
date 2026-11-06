{
  lib,
  python3,
  fetchFromGitHub,
}:
let
  python = python3.override {
    self = python;
    packageOverrides = self: super: {
      urwid = super.urwid.overrideAttrs ({
        version = "3.0.5";
        src = fetchFromGitHub {
          owner = "urwid";
          repo = "urwid";
          tag = "3.0.5";
          hash = "sha256-9ajcpyQTSASz8A4eM78vPjL+9Rk07Q30JmIrSx0Crpo=";
        };
      });
    };
  };
in

python.pkgs.buildPythonPackage (finalAttrs: {
  pname = "urwid-utils";
  version = "0.1.3.dev0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tonycpsu";
    repo = "urwid_utils";
    rev = "v${finalAttrs.version}";
    hash = "sha256-0tdWf22nDiFNZChmH8ibvfsVUONJ0p4KqmUlnr99EbE=";
  };

  # recursively replace display_common with display.common
  preBuild = ''
    find . -type f -name "*.py" \
      -exec sed -i 's/urwid.display_common/urwid.display.common/g' {} +
    find . -type f -name "*.py" \
      -exec sed -i 's/urwid.escape/urwid.display.escape/g' {} +
  '';

  build-system = [
    python.pkgs.setuptools
    python.pkgs.wheel
  ];

  dependencies = [ python.pkgs.urwid ];

  pythonImportsCheck = [
    "urwid_utils"
  ];

  meta = {
    description = "A collection of simple, straightforward, but extensible utilities for the urwid package";
    homepage = "https://github.com/tonycpsu/urwid_utils";
    license = lib.licenses.mit;
  };
})
