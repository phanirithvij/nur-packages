{
  rclone,
  fetchFromGitHub,
}:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.73.1-unstable-2026-05-22";
    src =
      (fetchFromGitHub {
        owner = "tgdrive";
        repo = "rclone";
        rev = "f748ef6452d44a988de8cc8192bbc23b26c881a5";
        hash = "sha256-ispIoUkbXuKzduE+Yk2VY/CNDU5/7igPluVVc74q3/8=";
      })
      // {
        tag = "faketag-to-allow-eval";
      };
    vendorHash = "sha256-COylZ9NTKQMMeh8dZNO4rOSmONboHRSIDuR/2FfsJuM=";
    doInstallCheck = false;
    ldflags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
