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
        version = "0.10.1-unstable-2025-12-08";
        src = fetchFromGitHub {
          owner = "git-bug";
          repo = "git-bug";
          rev = "cf47635eba59e8d6ec70bedbb3dc6cf97af45233";
          hash = "sha256-66jNM5309wjGHS0llqSnwmzUFeRXKWmkgBfg5bGL/DI=";
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
