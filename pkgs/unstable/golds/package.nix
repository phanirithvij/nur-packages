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
      hash = "sha256-3jedSlH22jDxhrpUcb+vCKDunTEX0zRW9SIMDTg5ELs=";
    };
    vendorHash = "sha256-Uj6MDsIMP+dSl1EK1E9DeNbJINngPc4DD9NzbFycuz4=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
