{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.1-unstable-2025-08-28";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "191da5b868a41c05c55ba8636e1384dbab63609c";
      hash = "sha256-R9WUjtMza8ifKa+thMCTfLLSVMYsCraXcpv7swyyqJk=";
    };
  }
)
