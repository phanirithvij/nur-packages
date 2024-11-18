{
  lib,
  buildGo123Module,
  fetchFromGitHub,
}:

buildGo123Module rec {
  pname = "pkgsite";
  version = "0-unstable-2024-11-13";

  src = fetchFromGitHub {
    owner = "golang";
    repo = "pkgsite";
    rev = "aa5dca7496c53df88ed8bb5279c4d76c02c78bd3";
    hash = "sha256-/Avn4mto0XAf34D8h4MsGzGWzWx0DMFlaeMx3pTIuIw=";
  };

  vendorHash = "sha256-i6l3PSYpHm7l6PdsKepOk7sXhVuQh1qWDuWmE7/Mj2Q=";

  subPackages = [ "cmd/pkgsite" ];

  ldflags = [ "-s" ];

  meta = {
    description = "Mirror] Home of the pkg.go.dev website";
    homepage = "https://github.com/golang/pkgsite";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "pkgsite";
  };
}
