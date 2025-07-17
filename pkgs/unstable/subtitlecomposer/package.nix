{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-07-16";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "a5a9b4916787f3b5263945cd63840fcb8e5a43cf";
      hash = "sha256-3BugV0/ijuoHr66o54w2FtAk6DVlPSwFqPXsTNhEEkA=";
    };
  }
)
