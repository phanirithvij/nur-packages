{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-06-15";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "e986e3cb886fc01c259157aeb2fb07bf035c982c";
      hash = "sha256-EI/uJ6SI6WlBpQHBn/G9yG72JeNyd7Byic+ACDcwGiA=";
    };
  }
)
