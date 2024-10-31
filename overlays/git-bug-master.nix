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
            hash = "sha256-or3vTUpUogk0GxWH2oL0ySwqJVx62ko0X4sSJMjOJg0=";
          };
          vendorHash = "sha256-B8pP6SS6UrODWaTONsu9dj+NnC/PxNOzyoZhXyqGjSY=";
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