{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-04-05";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "6ef05eed147f90cef5c962d42f4c7bb145f082fd";
      hash = "sha256-0WhoNr251EeoTby2RSROiueGEG6TuQNFzC5qMDYVIEA=";
    };
  }
)
