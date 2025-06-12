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
            hash = "sha256-MvohQ95RuUhwdfgoYCppIEG3mq4QhuNDqfLUMlTh7lI=";
          };
          vendorHash = "sha256-sUNOORr5G9gYAh6nIb2YRAgSM2pSEa3FzmkudALqgVI=";
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
