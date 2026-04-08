{
  git-bug,
  fetchFromGitHub,
}:
git-bug.overrideAttrs (prevAttrs: {
  pname = "git-bug";
  version = "0.10.1-unstable-2026-04-07";
  src = fetchFromGitHub {
    owner = "git-bug";
    repo = "git-bug";
    rev = "251a67a8b2145381b4c0552d25727e10cacc8628";
    hash = "sha256-uwbuawdxg0Rugd8nIi2/PKIYb0TDQebC4AJMmgHvzrg=";
  };
  vendorHash = "sha256-cvzwDKo8vT0afmgJrlRiS6pwmobbOyoHgoIHTiuU898=";
  ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
})
