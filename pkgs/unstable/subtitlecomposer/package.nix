{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-03-19";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "ae70f5fa5437ab0fd04369eed4bee77d7035eb79";
      hash = "sha256-9/CfqtvO/+WUet4mXSVKe1Fz5yXvvXvqV9JGjPJn+Us=";
    };
  }
)
