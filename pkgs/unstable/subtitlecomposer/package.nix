{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-10-29";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "7315dfeb1d495d13242a4ae95b393c92f8517acd";
      hash = "sha256-vuZzCfIqK+DIExBzcSEUhOrX2fb3MtM1AnFJfzQL1Io=";
    };
  }
)
