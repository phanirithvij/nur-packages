{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-09-28";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "d8fdb6c0635c3bccd5becc1ec3c7b5da5b1b1dbd";
      hash = "sha256-4KUgzgjF65nICQPKkvLPVc9DLElOczZUmzLoQueqx0U=";
    };
  }
)
