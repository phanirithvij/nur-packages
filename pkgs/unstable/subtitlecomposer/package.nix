{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-12-10";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "5322757199a414ff29271690c666613b6501b607";
      hash = "sha256-+MRkh/I7XnWdw5HDo+mtTvlBF0npOUwWBuQ5ZDnPHhQ=";
    };
  }
)
