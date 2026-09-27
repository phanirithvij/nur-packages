{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-09-26";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "2cf817d6438ad74f926e9dbf152e99676d0363fc";
      hash = "sha256-Kun2PAosO5GrY5kf8xOfjug4JQN3oXmRQHSRFKepHMg=";
    };
  }
)
