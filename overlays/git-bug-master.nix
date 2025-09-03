_: p: {
  git-bug = p.git-bug.override {
    buildGoModule =
      args:
      p.buildGoModule (
        args
        // rec {
          pname = "git-bug";
          version = "0.10.1-unstable-2025-08-30";
          src = p.fetchFromGitHub {
            owner = "git-bug";
            repo = "git-bug";
            rev = "9427c459ab325d37653453b0c19529ed6b1af61a";
            hash = "sha256-CfsRncRl2PDDGZgQt0r+TyH8GEIDldsEl6PGP7umk2A=";
          };
          vendorHash = "sha256-fPS+IJ9XjJEmglmJmUMXm5zldsCZD9rMMJ7jZSJUFOI=";
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
