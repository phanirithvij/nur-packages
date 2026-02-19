{
  git-bug,
  fetchFromGitHub,
}:
git-bug.overrideAttrs (prevAttrs: {
  pname = "git-bug";
  version = "0.10.1-unstable-2026-02-11";
  src = fetchFromGitHub {
    owner = "git-bug";
    repo = "git-bug";
    rev = "7468b3793fbf1eeef4637d91291494fd8454ae7c";
    hash = "sha256-8X77YkYjZexwHF9Y1aZHNZL5UThT3F/7iZjNCdqwhvk=";
  };
  vendorHash = "sha256-F5E7Xu6t3f4rDaA8izqzR6ha8EHSdiQSHdj/LlVBAj0=";
  ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
})
