{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-04-11";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "452a080974c7c05ff729da7b6e569696fef76863";
      hash = "sha256-1cwiJDOBu03u+BwuKrAGJGrANdfscSm7HbwzBrx2MLs=";
    };
  }
)
