{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2026-09-05";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "6cd5f4784081c0293f2d166c9dd90a61d15a866d";
      hash = "sha256-iWpvsQH3dNTc42xV8Q5xsFnDwcAuXAwJS99sKbGuDfg=";
    };
  }
)
