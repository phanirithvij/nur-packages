{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-06-29";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "5b2d923ec96c1bd3063036eadfce4a606d5ba90f";
      hash = "sha256-p3Qj1pK9VSsRRnapCvz67VtouGRv25AFqaL52zew14M=";
    };
  }
)
