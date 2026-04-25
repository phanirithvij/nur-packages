{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-04-12";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "ca02ad6b5a31ee60322c87e33745a511affbd486";
      hash = "sha256-0DzjjhWYLd0FOPTy9a6OVWl0gkmpe5k04GLC8CWlx5o=";
    };
  }
)
