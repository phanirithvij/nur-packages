{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    # TODO unstable date so I can update
    version = "tgdrive-main";
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "refs/heads/main";
      hash = "sha256-pQ+bRCw6A2TLzQduY7dIqL+xtXdkXP7Ch0OxyDxRW50=";
    };
    vendorHash = "sha256-Mdh6/4B/B/JsdMwO/1aopuJHE4020nYtBC4GdvdKJvg=";
    ldFlags = [
      "-s"
      "-w"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
