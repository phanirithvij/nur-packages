{
  git-bug,
  buildGoModule,
  fetchFromGitHub,
}:
git-bug.override {
  buildGoModule =
    args:
    buildGoModule (
      args
      // rec {
        pname = "git-bug";
        version = "0.10.1-unstable-2026-01-27";
        src = fetchFromGitHub {
          owner = "git-bug";
          repo = "git-bug";
          rev = "0d58c4961980536c6e33638919ebac52d58bc757";
          hash = "sha256-72yg5BZwsxyk2SwnpSJDKDoECWTLB/7VwoPYu48tLEE=";
        };
        vendorHash = "sha256-n/95OQVHqibb2dm04KyR5mPlSWqDlb0nAW5J/zASf3g=";
        ldflags = [
          "-s"
          "-X github.com/MichaelMure/git-bug/commands.GitCommit=${version}"
          "-X github.com/MichaelMure/git-bug/commands.GitLastTag=${version}"
          "-X github.com/MichaelMure/git-bug/commands.GitExactTag=${version}"
        ];
      }
    );
}
