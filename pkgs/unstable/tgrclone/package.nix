{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.73.1-unstable-2026-02-04";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "cf4e39c6703245dc66b5bfc0cc30821f95d2434f";
      hash = "sha256-xGSMpQahCkzWKaQtM/MPZw5tCM1ZqNe9IMEnMjkn4i4=";
    };
    vendorHash = "sha256-LomeLlk0d/HTL0NKmbd083u7BHsy4FmAah9IzvmtO2s=";
    ldFlags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
