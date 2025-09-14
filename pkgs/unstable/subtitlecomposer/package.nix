{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-09-14";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "2bde53818dfafb9f72a8b79349f786cf46f81d35";
      hash = "sha256-zGbI960NerlOEUvhOLm+lEJdbhj8VFUfm8pkOYGRcGw=";
    };
  }
)
