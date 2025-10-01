{
  fetchFromGitHub,
  golds,
}:
golds.overrideAttrs (
  finalAttrs: _: {
    version = "0.8.2-unstable-2025-09-25";
    src = fetchFromGitHub {
      owner = "go101";
      repo = "golds";
      rev = "bc29975d59514b0bd64f5bac4c87f975971c670d";
      hash = "sha256-6jtBwET3JSSh2DQq9MtLn2YokfK9ODYtYrcfI0W8m5I=";
    };
    vendorHash = "sha256-CL9CdLGeMTxXazJUr2+syQYJZXafX6ARzmEOHn7l14I=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
