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
            hash = "sha256-OaJcQySL2kAcdHlVBxD7TKmQFyzNBT3OX77rQRzTPhg=";
          };
          vendorHash = "sha256-2ExmEXQZYjXLmBzsFn7Wa72ygcqIVxEYVKobwxHN+EE=";
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
