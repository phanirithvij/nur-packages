{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-10-13";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "146018447b5150f2c592d7097a7531d20ce116a0";
      hash = "sha256-DjipxrlnovXRyijl9RKdVnxLnNo0qJENoMTkUr5uyiY=";
    };
  }
)
