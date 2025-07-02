{
  fetchFromGitHub,
  golds,
}:
golds.overrideAttrs (
  finalAttrs: _: {
    version = "0.7.6-unstable-2025-06-23";
    src = fetchFromGitHub {
      owner = "go101";
      repo = "golds";
      rev = "d41899fd1d4138a6dce49c548e3cfb95c6314890";
      hash = "sha256-3jedSlH22jDxhrpUcb+vCKDunTEX0zRW9SIMDTg5ELs=";
    };
    vendorHash = "sha256-Uj6MDsIMP+dSl1EK1E9DeNbJINngPc4DD9NzbFycuz4=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
