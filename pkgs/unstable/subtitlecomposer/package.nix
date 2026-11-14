{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-11-14";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "aff2bb731d4cc18c676c2e424ef359ac3e850fc2";
      hash = "sha256-U2llLup7EliE+DMhYJ+/2kzrQgiKTOmctF0GX3O1lD0=";
    };
  }
)
