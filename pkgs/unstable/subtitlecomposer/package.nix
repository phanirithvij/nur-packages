{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-11-04";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "b3f158cb1c82a47bdfb8593f3cb3e56dce3ddcf9";
      hash = "sha256-nOBiJJPu09gPATu7KfFYr3XgN8vko5vzXLnkhsKCq+8=";
    };
  }
)
