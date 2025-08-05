_: p: {
  git-bug = p.git-bug.override {
    buildGoModule =
      args:
      p.buildGoModule (
        args
        // rec {
          pname = "git-bug";
          version = "0.10.1-unstable-2025-08-03";
          src = p.fetchFromGitHub {
            owner = "git-bug";
            repo = "git-bug";
            rev = "791a80d0fe2ab519372ba472e0e148afc3136b6b";
            hash = "sha256-hmDlhNeI2k31Nxx0ZbHKho0QxmZCUX+lVNNqjc8JjYg=";
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
