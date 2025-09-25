{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-09-23";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "d0d34ed3a307d9234c4b7b49809e2529eff0e31f";
      hash = "sha256-gW/MqOWzIQzthxevmegGOWQhOarOGiy2u8rAy8KzMY8=";
    };
  }
)
