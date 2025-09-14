{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.71.0-unstable-2025-09-11";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "f83d9e41ad1f09d2060c3aa74494f910be9448af";
      hash = "sha256-8Q8aR8aY3f8zfdhf7vpY/axxDaMSNEwI446uYWs/pXI=";
    };
    vendorHash = "sha256-Hapwa+WYz6a22HauRjRUl7q0ZlwR/j/zwex0VebgC+g=";
    ldFlags = [
      "-s"
      "-w"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
