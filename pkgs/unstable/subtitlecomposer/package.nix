{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-09-16";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "a6fe3b9970a495a75be47a32ec4c42e4b7f80334";
      hash = "sha256-ndYmlWFvZhOMMJ5PGJXrzdeaolsrjsqTTEvLDnJiJzc=";
    };
  }
)
