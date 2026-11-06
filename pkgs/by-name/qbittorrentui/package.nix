{
  lib,
  python3,
  fetchFromGitHub,
  panwid,
}:

python3.pkgs.buildPythonApplication {
  pname = "qbittorrentui";
  version = "0.3.11-unstable-2026-11-01";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rmartin16";
    repo = "qbittorrentui";
    rev = "3fa8313e4bd96b359556959d2b530d185be0c6f4";
    hash = "sha256-wOdGDGQ0ZdIDoBjjkK6PF81F4Ur/JY9DXT3NR1rA93U=";
  };

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  dependencies = with python3.pkgs; [
    blinker
    qbittorrent-api
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
