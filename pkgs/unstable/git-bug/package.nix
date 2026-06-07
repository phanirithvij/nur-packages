{
  git-bug,
  fetchFromGitHub,
}:
git-bug.overrideAttrs (prevAttrs: {
  pname = "git-bug";
  version = "0.10.1-unstable-2026-05-31";
  src = fetchFromGitHub {
    owner = "git-bug";
    repo = "git-bug";
    rev = "9a57c31cb67c707c469ed89d2ce3f120cb420c22";
    hash = "sha256-519toUYM8Vyx69H9mnBfWfQhIySC8n5fdabjC+5fQoE=";
  };
  vendorHash = "sha256-cvzwDKo8vT0afmgJrlRiS6pwmobbOyoHgoIHTiuU898=";
  ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
})
