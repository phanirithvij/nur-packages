{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-08-13";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "00616fe1f3e90617ba4dc07189d3e7a124751278";
      hash = "sha256-GaYuPim0/sKf1RAYc5n6As64zcZ70z2U03GqfZ+mfhc=";
    };
  }
)
