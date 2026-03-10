{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-03-08";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "64ac4eb32b41cb3ebe2f5bb23d83d45b38720d60";
      hash = "sha256-gY9KUq6byZ8gvvTsOOAB39JbCQsj54mPwuqSB7u5IVI=";
    };
  }
)
