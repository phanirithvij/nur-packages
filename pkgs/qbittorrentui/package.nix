{
  lib,
  python3,
  fetchFromGitHub,
  panwid,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "qbittorrentui";
  version = "0.3.6-unstable-2025-01-01";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rmartin16";
    repo = "qbittorrentui";
    rev = "71a861a4346e190ecf5bd64a49a9b7dcf2473694";
    hash = "sha256-YUTYLwL6AaC8MNCPuSgL/l7hkzGqG3rdsX5SLU3LoUk=";
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
