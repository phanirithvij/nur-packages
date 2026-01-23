{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.72.1-unstable-2026-01-18";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "79cc5fd7489bbee4ec45f1abf146c69a3b3d663c";
      hash = "sha256-3TV4LMb145Pz1lVkDQSM8o6N25taFwO/ahCs7vcnq5I=";
    };
    vendorHash = "sha256-tNeL43WGWeX88vXJwQzxubUPIyejl3PPHXLc8oNeno4=";
    ldFlags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
