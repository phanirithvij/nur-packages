{ rclone, fetchFromGitHub }:
rclone.overrideAttrs (
  f: _: {
    pname = "rclone";
    version = "1.72.1-unstable-2025-12-27";
    doInstallCheck = false;
    patches = [ ]; # no patches
    src = fetchFromGitHub {
      owner = "tgdrive";
      repo = "rclone";
      rev = "4e101c1c77eb5e4145435c60bd80a8b049db5e08";
      hash = "sha256-blH4vsntdY2EbS6pvZ69U3waGbYF2ryo30UQzrg4bQk=";
    };
    vendorHash = "sha256-tNeL43WGWeX88vXJwQzxubUPIyejl3PPHXLc8oNeno4=";
    ldFlags = [
      "-s"
      "-X github.com/rclone/rclone/fs.Version=${f.version}"
    ];
  }
)
