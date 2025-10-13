{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-10-13";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "1e11d53565ab6df3ba8329072e7b4b12f9f88d72";
      hash = "sha256-URVxsmhaXm4Ixjyt4QulOPZkgl7hDFgx27OEM8dZTeQ=";
    };
  }
)
