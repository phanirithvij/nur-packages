{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-09-08";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "15522bb0c1d615fd49f1110cf4b69c8d0acb736d";
      hash = "sha256-svvayWNsZ5N4W5ZKhLTNiRepDTk7uAqlLRAwzJ3MDFM=";
    };
  }
)
