{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-11-11";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "2fde46d8b741b340804ddb937b84c6d0c332004d";
      hash = "sha256-XyyBwljXmVQ4phygn4ZYBAa5EcVhvwSNVSwZCfaoGBM=";
    };
  }
)
