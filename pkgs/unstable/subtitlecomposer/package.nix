{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-12-30";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "37fb3188fed4d77f36d6e922ca8d1c434acb014c";
      hash = "sha256-NPffDrlwSnrCdwLspEn4+7nSCHRwIEn6E7JIsMtStS0=";
    };
  }
)
