_: p: {
  git-bug = p.git-bug.override {
    buildGoModule =
      args:
      p.buildGoModule (
        args
        // rec {
          pname = "git-bug";
          version = "0.10.1-unstable-2025-06-11";
          src = p.fetchFromGitHub {
            owner = "git-bug";
            repo = "git-bug";
            rev = "6a3ca9e5c71550327f4d328f681c3a1ee5f9ea20";
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
