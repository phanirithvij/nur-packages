{
  rclone,
  fetchFromGitHub,
}:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.73.1-unstable-2026-09-02";
    src =
      (fetchFromGitHub {
        owner = "tgdrive";
        repo = "rclone";
        rev = "0408e9479c981b6ebd5561db1a439657dadb9dd0";
        hash = "sha256-lUnq7zFsLlfJamoJ/by2rjkmEaiKanw2TezKhPnrV7E=";
      })
      // {
        tag = "faketag-to-allow-eval";
      };
    vendorHash = "sha256-PxKjyuEIi0umBr23kif1cB4Ok3G3akRLGECCosk34sE=";
    doInstallCheck = false;
    ldflags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
