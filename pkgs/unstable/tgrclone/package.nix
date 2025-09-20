{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.71.0-unstable-2025-09-19";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "eb07056aafd128d06da03be9dc9aa8bd41198cd9";
      hash = "sha256-omaNYOV7gzep7tDQLvdbqTSp0JgPrs7j+AS8QVKu0mo=";
    };
    vendorHash = "sha256-Hapwa+WYz6a22HauRjRUl7q0ZlwR/j/zwex0VebgC+g=";
    ldFlags = [
      "-s"
      "-w"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
