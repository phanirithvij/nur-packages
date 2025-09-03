{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-09-03";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "cccda8d45a779ad58f9a96068802fde8afa210c7";
      hash = "sha256-PSbGn0zIhwmN6Kl9ePUBi0iZe8luWHX9OmQHTvvQ7oU=";
    };
  }
)
