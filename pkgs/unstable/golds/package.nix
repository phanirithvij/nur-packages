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
      hash = "sha256-maYkVZlr8VW3nsNLVD+ib8TfltBkDrgWiC7VyeEJIy4=";
    };
    vendorHash = "sha256-Sy9O23iCW8voImPFQkqczPxqGyD5rf0/tKxaRDFgbSs=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
