{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-11-23";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "47327a1382b4150f573f6c73d90ce964ff8e983b";
      hash = "sha256-vK46VPZrLhydxv8L1bxlftLrWHLBZ0UfgLg/2P5k/+c=";
    };
  }
)
