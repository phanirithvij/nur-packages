{
  lib,
  buildGo123Module,
  fetchFromGitHub,
}:

buildGo123Module rec {
  pname = "pkgsite";
  version = "0-unstable-2024-10-04";

  src = fetchFromGitHub {
    owner = "golang";
    repo = "pkgsite";
    rev = "78391ec0fb952e63359246d12071f3d2521a3cdf";
    hash = "sha256-16EcjtwMfBalOjL1cZfQOWT/WwNoNWfHyKvMdkUT9uQ=";
  };

  vendorHash = "sha256-nYdyd6D7MeWytWstH89tSTgiH22u55mn3BMZWtxo9qY=";

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
