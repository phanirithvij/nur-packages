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
      hash = "sha256-ExvCVGWYAngasnDHVzBLeLmms4cFNcQ/KzuE4t3r36A=";
    };
    vendorHash = "sha256-omjHRZB/4VzPhc6RrFY11s6BRD69+Y4RRZ2XdeKbZf0=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
