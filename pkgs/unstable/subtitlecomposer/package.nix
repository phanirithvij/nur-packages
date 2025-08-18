{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-08-18";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "7ebb763dbfbb010697d60a657630db3e9cd17ffd";
      hash = "sha256-r49cY0OlUiKFFnVRjYJIJadeIiRUt/3FqMjw+NLrNjo=";
    };
  }
)
