{
  rclone,
  fetchFromGitHub,
}:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.75.4-unstable-2026-10-14";
    src =
      (fetchFromGitHub {
        owner = "tgdrive";
        repo = "rclone";
        rev = "0408e9479c981b6ebd5561db1a439657dadb9dd0";
        hash = "sha256-lUnq7zFsLlfJamoJ/by2rjkmEaiKanw2TezKhPnrV7E=";
      })
      // {
        tag = "ddd4d031cbf5c0eefec31e51b7f1906e35a4acd0";
      };
    vendorHash = "sha256-PxKjyuEIi0umBr23kif1cB4Ok3G3akRLGECCosk34sE=";
    doInstallCheck = false;
    ldflags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
