{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-06-04";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "3b7969eb6dfe302a3aea4be37d7ee86c555aa161";
      hash = "sha256-eGWg1qMG7mWOYnOLhdmqAcKvYoNsZ0DO9UdTDMtrjlo=";
    };
  }
)
