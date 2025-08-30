{
  fetchFromGitHub,
  golds,
}:
golds.overrideAttrs (
  finalAttrs: _: {
    version = "0.8.1-unstable-2025-08-30";
    src = fetchFromGitHub {
      owner = "go101";
      repo = "golds";
      rev = "0e74a2d3a28751b9634e9a8a4112ab9b40c0ecb1";
      hash = "sha256-RM9ltqkOByOg1ZUF7ZXZcWTivlUKrNbZYgcFpwRwNUk=";
    };
    vendorHash = "sha256-CL9CdLGeMTxXazJUr2+syQYJZXafX6ARzmEOHn7l14I=";
    # version hardcoded in source
    doInstallCheck = false;
  }
)
