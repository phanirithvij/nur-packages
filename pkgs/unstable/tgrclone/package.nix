{
  rclone,
  fetchFromGitHub,
}:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.73.1-unstable-2026-04-01";
    src =
      (fetchFromGitHub {
        owner = "tgdrive";
        repo = "rclone";
        rev = "971ea5c8c01370d4288c58cf461217c1074efa70";
        hash = "sha256-wNIh2kc7yyWK/jEmTPFy4+d5cxn07aj9zei1eYD0RGE=";
      })
      // {
        tag = "faketag-to-allow-eval";
      };
    vendorHash = "sha256-88QMlF4V2rw+o44UZ98g6aMUZbziK/ze7kh4Vkj9g8I=";
    doInstallCheck = false;
    ldflags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
