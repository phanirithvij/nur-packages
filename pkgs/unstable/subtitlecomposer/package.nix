{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-11-17";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "ef9f8e00619b8d71ff816dcaed25698a42167eb6";
      hash = "sha256-vK46VPZrLhydxv8L1bxlftLrWHLBZ0UfgLg/2P5k/+c=";
    };
  }
)
