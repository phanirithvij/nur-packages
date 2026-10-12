{
  rclone,
  fetchFromGitHub,
}:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.75.3-unstable-2026-10-11";
    src =
      (fetchFromGitHub {
        owner = "tgdrive";
        repo = "rclone";
        rev = "0408e9479c981b6ebd5561db1a439657dadb9dd0";
        hash = "sha256-lUnq7zFsLlfJamoJ/by2rjkmEaiKanw2TezKhPnrV7E=";
      })
      // {
        tag = "7c71e41a6a2362aa699ad9434e1c6be83bb1589f";
      };
    vendorHash = "sha256-PxKjyuEIi0umBr23kif1cB4Ok3G3akRLGECCosk34sE=";
    doInstallCheck = false;
    ldflags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
