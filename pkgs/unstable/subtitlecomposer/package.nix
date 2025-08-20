{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-08-19";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "ff70eb9d7c2ce5b5ba20b1f529a4ed916a344833";
      hash = "sha256-ByQN/gydBsGzHWiAt3hMhryRoEwTXjxcCD9h0JBjoLE=";
    };
  }
)
