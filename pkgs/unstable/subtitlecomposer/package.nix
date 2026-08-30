{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-08-26";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "553f377ae6ea59df4c1c142a64fa41a6d79fd812";
      hash = "sha256-usV/sIXBsam416lY0lmRybQitBRrEsQ0X0d47ONHZyE=";
    };
  }
)
