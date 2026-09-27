{
  rclone,
  fetchFromGitHub,
}:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.73.1-unstable-2026-09-09";
    src =
      (fetchFromGitHub {
        owner = "tgdrive";
        repo = "rclone";
        rev = "0408e9479c981b6ebd5561db1a439657dadb9dd0";
        hash = "sha256-lUnq7zFsLlfJamoJ/by2rjkmEaiKanw2TezKhPnrV7E=";
      })
      // {
        tag = "5895a84debed54193f0979c1b9d7ef506f4434f5";
      };
    vendorHash = "sha256-PxKjyuEIi0umBr23kif1cB4Ok3G3akRLGECCosk34sE=";
    doInstallCheck = false;
    ldflags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
