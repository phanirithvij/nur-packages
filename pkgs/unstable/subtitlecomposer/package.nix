{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-05-26";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "ac4fce1c7b938540c8454270fd70cbed5f12e581";
      hash = "sha256-N1OchAsiEdITBK9dfnT0BRGbxJLdKh8shTKNe096YAA=";
    };
  }
)
