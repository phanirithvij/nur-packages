{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-03-04";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "cdf1f3503525553da9091f3f77f9844443e3f909";
      hash = "sha256-jH7LbBmmKufVL9RGbU1qBeG9f4NlOIFKd0ydrFiwqCw=";
    };
  }
)
