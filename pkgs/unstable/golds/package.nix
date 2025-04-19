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
      hash = "sha256-j6k68+hiXsXW5WLnmbN/iFLFpyU64z/1+DKuaAnNbac=";
    };
    vendorHash = "sha256-Sy9O23iCW8voImPFQkqczPxqGyD5rf0/tKxaRDFgbSs=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
