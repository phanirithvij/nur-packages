{
  lib,
  python3,
  fetchFromGitHub,
  panwid,
}:

python3.pkgs.buildPythonApplication {
  pname = "qbittorrentui";
  version = "0.3.11-unstable-2026-09-09";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rmartin16";
    repo = "qbittorrentui";
    rev = "0ea2d4402ea489795b4080e676796d85d0584f55";
    hash = "sha256-VXOHmoKq2Gk4LXTpGXNPRBCtWPKWC8sN4f7fT/sz8gg=";
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
