_: p: {
  git-bug = p.git-bug.override {
    buildGoModule =
      args:
      p.buildGoModule (
        args
        // rec {
          pname = "git-bug";
          version = "master";
          src = p.fetchFromGitHub {
            owner = "git-bug";
            repo = "git-bug";
            rev = "refs/heads/${version}";
            hash = "sha256-DcimoSAY3S6bxuwGdESHevLPvJMG5ewdFE7OBkYvoKg=";
          };
          vendorHash = "sha256-aeFbK9IxqC6LOgEuTrcSPNk3UX7xR1asrrYWyHtLLEc=";
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
