{
  lib,
  python3,
  fetchFromGitHub,
  raccoon,
  urwid-utils,
  orderedattrdict,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "panwid";
  version = "0.3.5-unstable-2022-01-04";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tonycpsu";
    repo = "panwid";
    rev = "e85bcfb95ef7e11aa594a996bae829f67787e1ee";
    hash = "sha256-bksH8nKexiZZLGu0Og8wwAXeZR1wAtpxt1JXqTieJAo=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  pythonRelaxDeps = [ "urwid-utils" ];

  dependencies = with python3.pkgs; [
    urwid
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
