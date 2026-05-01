{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-04-27";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "13c593681c019e55aef36d653220579053ce82e5";
      hash = "sha256-zFEuNB1IyiJnuoBUMwsaR/twWaltc7L6AJ3KHGpbU1U=";
    };
  }
)
