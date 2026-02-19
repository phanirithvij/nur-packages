{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-02-24";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "a8edb4980ea7ddb387d9f03af0574bc0a289ed36";
      hash = "sha256-EzoX06sVHKZPvQ6Dx/9D5XoymzvTdJYbtib6n/M7OF4=";
    };
  }
)
