{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-11-06";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "3885e75eab531aa578a6d99ec35e241156b0a56a";
      hash = "sha256-Ws800C+xDAzYh06Bojxb14UCkUW7Luc1AHUBdlRUyvQ=";
    };
  }
)
