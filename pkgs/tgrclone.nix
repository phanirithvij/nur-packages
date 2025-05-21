{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    # TODO unstable date so I can update
    version = "tgdrive-main";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "refs/heads/main";
      hash = "sha256-WlhJh7hqZAF0c5vQ9+vvG/cNDz4BGqbAQJXuwssytdY=";
    };
    vendorHash = "sha256-Nt+KFhOfY1z/q6xVJZ/aQvBWOwr7txkansF6PKxGdSY=";
    ldFlags = [
      "-s"
      "-w"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
