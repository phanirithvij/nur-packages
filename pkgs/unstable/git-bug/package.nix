{
  git-bug,
  fetchFromGitHub,
}:
git-bug.overrideAttrs (prevAttrs: {
  pname = "git-bug";
  version = "0.10.1-unstable-2026-04-08";
  src = fetchFromGitHub {
    owner = "git-bug";
    repo = "git-bug";
    rev = "f5dc9c4cbd42c114c11ee21cc394ad0ff8cc5ffc";
    hash = "sha256-Lzk7l7a2Y5aRoV4emVLlcU1bkLwFRku36AgoWn004Lw=";
  };
  vendorHash = "sha256-cvzwDKo8vT0afmgJrlRiS6pwmobbOyoHgoIHTiuU898=";
  ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
})
