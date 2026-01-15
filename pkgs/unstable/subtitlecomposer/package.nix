{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-01-12";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "2cce6c32eea38d72d997b0a3b1e072e6463a72a6";
      hash = "sha256-3wEIusQStOI+g0UH9QBJXc6dtIMxwYUglsfoolMBviA=";
    };
  }
)
