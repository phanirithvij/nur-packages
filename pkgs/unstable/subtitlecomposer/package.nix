{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-10-17";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "7675e244bd23649ebe164b25eeade6b008ca9e2c";
      hash = "sha256-HhxaJH/CUwgueMUlMu53z7qkiNlUNU28NtZVUARCOvU=";
    };
  }
)
