{
  lib,
  buildGoModule,
  fetchFromGitHub,
  libx11,
  libxi,
  nix-update-script,
}:

buildGoModule (finalAttrs: {
  pname = "autorotate";
  version = "0-unstable-2025-01-27";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "undg";
    repo = "autorotate";
    rev = "ac3106d9858110de01d1ec2fa3f16c445d910af9";
    hash = "sha256-y6cUJN/0sOdRB/QrFyeFVguMwTcfQ3RQZGTxGD0cyzU=";
  };

  vendorHash = "sha256-e4r5O1s1AkgcA+1N7pnZ3HALOK51wJ+8DVhhx5YvoiM=";

  ldflags = [ "-s" ];

  buildInputs = [
    libx11
    libxi
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Auto rotate 2in1 (touch)screens";
    homepage = "https://github.com/undg/autorotate";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "autorotate";
  };
})
