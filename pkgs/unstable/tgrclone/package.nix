{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.72.1-unstable-2026-01-24";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "fd04c47a09d0a6f3538fbb084ce8d5ccf0a373fd";
      hash = "sha256-/FUkrb9ugVORYN8rOgy6tb4Uk9K3hy3CuzvYUmbSzgg=";
    };
    vendorHash = "sha256-tNeL43WGWeX88vXJwQzxubUPIyejl3PPHXLc8oNeno4=";
    ldFlags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
