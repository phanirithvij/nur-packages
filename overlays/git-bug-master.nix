_: p: {
  git-bug = p.git-bug.override {
    buildGoModule =
      args:
      p.buildGoModule (
        args
        // rec {
          pname = "git-bug";
          version = "0.10.1-unstable-2025-07-18";
          src = p.fetchFromGitHub {
            owner = "git-bug";
            repo = "git-bug";
            rev = "846c8ab43507eb0a1890ce74be107439778f7dc0";
            hash = "sha256-xjpgILc88Avnoyyq3taiAHjkUYITr7tBDkWhkyCSpD4=";
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
