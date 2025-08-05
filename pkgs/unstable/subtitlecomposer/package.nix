{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-08-05";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "4835a57d0d19be8d19bf4ae002bf6815d256bc01";
      hash = "sha256-njcZjqBRiDsweqmPqAFjexcB3zqRKlBfjgvdANWDzuw=";
    };
  }
)
