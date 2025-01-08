{
  fetchFromGitHub,
  golds,
}:
golds.overrideAttrs (
  finalAttrs: _: {
    version = "develop";
    src = fetchFromGitHub {
      owner = "go101";
      repo = "golds";
      rev = "refs/heads/${finalAttrs.version}";
      hash = "sha256-kVXr/5qJCTjpfRpz2mDIsMRirp5dT5aGo/BlLR9Qp0M=";
    };
    vendorHash = "sha256-Sy9O23iCW8voImPFQkqczPxqGyD5rf0/tKxaRDFgbSs=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
