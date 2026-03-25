{
  git-bug,
  fetchFromGitHub,
}:
git-bug.overrideAttrs (prevAttrs: {
  pname = "git-bug";
  version = "0.10.1-unstable-2026-03-25";
  src = fetchFromGitHub {
    owner = "git-bug";
    repo = "git-bug";
    rev = "9b06f224354f3cf745ad6bf6620c1b04ca51077f";
    hash = "sha256-5zzBBkO0KCJkBHF8njk145W2fp00SJtYCvVUrvAxSIU=";
  };
  vendorHash = "sha256-N09CuyfXpyOeOe0kg4G0GtH3b1PH2R8K2RJiF4ZAtCM=";
  ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
})
