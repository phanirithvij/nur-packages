{
  git-bug,
  fetchFromGitHub,
}:
git-bug.overrideAttrs (prevAttrs: {
  pname = "git-bug";
  version = "0.10.1-unstable-2026-03-13";
  src = fetchFromGitHub {
    owner = "git-bug";
    repo = "git-bug";
    rev = "c018806d31384d9eb4cf235ad2e3d886d2ccc14d";
    hash = "sha256-lz0jnH8nAqHEGryqGWa0aoB21kzwcjWBxNRLxIppYhs=";
  };
  vendorHash = "sha256-F5E7Xu6t3f4rDaA8izqzR6ha8EHSdiQSHdj/LlVBAj0=";
  ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
})
