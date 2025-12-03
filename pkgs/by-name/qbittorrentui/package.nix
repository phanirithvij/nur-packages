{
  lib,
  python3,
  fetchFromGitHub,
  panwid,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "qbittorrentui";
  version = "0.3.9-unstable-2025-12-01";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rmartin16";
    repo = "qbittorrentui";
    rev = "13b0824d06a3ebf60b3b49b67339dbc334b87157";
    hash = "sha256-AUvsGCW+CJpEKdVtickmxOuZ7vu1XWFskMA67kqBs1M=";
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
