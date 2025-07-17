_: p: {
  git-bug = p.git-bug.override {
    buildGoModule =
      args:
      p.buildGoModule (
        args
        // rec {
          pname = "git-bug";
          version = "0.10.1-unstable-2025-07-12";
          src = p.fetchFromGitHub {
            owner = "git-bug";
            repo = "git-bug";
            rev = "95e53ffb8fa2fbc41ccca89a85e320412e5b5733";
            hash = "sha256-U1AGMV8TTiU99XcDWZzqUkKvxVmePIh94TAyZAGolJw=";
          };
          vendorHash = "sha256-D6hmSPARvMbkfB+rHw/QJLUdDvV5muRqhwLSHIScWcg=";
          ldflags = [
            "-s"
            "-X github.com/MichaelMure/git-bug/commands.GitCommit=${version}"
            "-X github.com/MichaelMure/git-bug/commands.GitLastTag=${version}"
            "-X github.com/MichaelMure/git-bug/commands.GitExactTag=${version}"
          ];
        }
      );
  };
}
