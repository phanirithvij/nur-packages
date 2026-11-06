{
  lib,
  python3,
  fetchFromGitHub,
  raccoon,
  urwid-utils,
  orderedattrdict,
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

python.pkgs.buildPythonPackage {
  pname = "panwid";
  version = "0.3.5-unstable-2022-01-04";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tonycpsu";
    repo = "panwid";
    rev = "e85bcfb95ef7e11aa594a996bae829f67787e1ee";
    hash = "sha256-bksH8nKexiZZLGu0Og8wwAXeZR1wAtpxt1JXqTieJAo=";
  };

  build-system = with python.pkgs; [
    setuptools
    wheel
  ];

  pythonRelaxDeps = [ "urwid-utils" ];

  dependencies = with python.pkgs; [
    urwid-readline
    six
    raccoon
    urwid-utils
    orderedattrdict
  ];

  pythonImportsCheck = [
    "panwid"
  ];

  meta = {
    description = "A collection of widgets for urwid";
    homepage = "https://github.com/tonycpsu/panwid";
    license = lib.licenses.lgpl21Only;
  };
}
