{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-07-26";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "73c8c6b7f9db4113d2e8f7a543c97329d178c072";
      hash = "sha256-Xt885K63i9zSkGX2wUuoDwcbaXBqhqihHjj0eMo+3nU=";
    };
  }
)
