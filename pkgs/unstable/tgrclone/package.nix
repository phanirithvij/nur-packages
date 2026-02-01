{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.72.2-unstable-2026-01-30";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "02442931db5b3a18275a7cbd096cb7b930caf6f2";
      hash = "sha256-7RCSk6cDE1hiIZca5poLV4+V2Gbm4z5ZA+Epw4v+3SE=";
    };
    vendorHash = "sha256-tNeL43WGWeX88vXJwQzxubUPIyejl3PPHXLc8oNeno4=";
    ldFlags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
