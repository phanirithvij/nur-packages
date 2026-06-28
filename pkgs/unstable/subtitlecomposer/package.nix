{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-06-28";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "07b6d9b62c4bdbbdff376b0b64f20ca76bd21875";
      hash = "sha256-I3JG2LSXas7USqT/FMjBi+SHc25/DKCLciTPyzPc4Gc=";
    };
  }
)
