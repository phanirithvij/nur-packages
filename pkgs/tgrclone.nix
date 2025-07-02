{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.70.1-unstable-2025-06-21";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "a0477e9aaad13f74024f91bef936742b26969744";
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
