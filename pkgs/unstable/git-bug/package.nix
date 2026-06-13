{
  git-bug,
  fetchFromGitHub,
}:
git-bug.overrideAttrs (prevAttrs: {
  pname = "git-bug";
  version = "0.10.1-unstable-2026-06-10";
  src = fetchFromGitHub {
    owner = "git-bug";
    repo = "git-bug";
    rev = "57dc45277e0ae934345c47d09638184a0cf2ea9c";
    hash = "sha256-jGyMlu1qgL8qAk//uuSprbqge5bI042Ok19+rmgTvTQ=";
  };
  vendorHash = "sha256-cvzwDKo8vT0afmgJrlRiS6pwmobbOyoHgoIHTiuU898=";
  ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
})
