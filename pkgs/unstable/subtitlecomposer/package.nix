{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-12-07";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "46657151470e23d1e5c8385d771ebf70d1868b3a";
      hash = "sha256-5mCQuarVl9NRUMHHQHl1audcG1Fnq0tQeRznz9BQQJY=";
    };
  }
)
