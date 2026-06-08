{
  lib,
  python3,
  fetchFromGitHub,
  panwid,
}:

python3.pkgs.buildPythonApplication {
  pname = "qbittorrentui";
  version = "0.3.10-unstable-2026-05-30";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rmartin16";
    repo = "qbittorrentui";
    rev = "fafba3d3e708603a5f49447be63680737df5bbeb";
    hash = "sha256-ULgQyG7HpcSfcTO6lDWa8BXfiBhIPU+fWQcXGmuf1ps=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  dependencies = with python3.pkgs; [
    blinker
    qbittorrent-api
    urwid
    panwid
    platformdirs
  ];

  optional-dependencies = with python3.pkgs; {
    dev = [
      pre-commit
      tox
    ];
  };

  pythonRelaxDeps = [
    "urwid"
    "blinker"
  ];

  pythonImportsCheck = [
    "qbittorrentui"
  ];

  meta = {
    description = "Text user interface for qbittorrent";
    homepage = "https://github.com/rmartin16/qbittorrentui";
    license = lib.licenses.mit;
    mainProgram = "qbittorrentui";
  };
}
