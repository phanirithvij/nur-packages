{
  fetchFromGitHub,
  gama-tui,
}:
gama-tui.overrideAttrs (
  finalAttrs: _: {
    version = "1.2.1-unstable-2025-05-24";
    src = fetchFromGitHub {
      owner = "termkit";
      repo = "gama";
      rev = "0830db94f899e25f8aee56443b9dc6e76bdcc6b6";
      hash = "sha256-h1gzam/eDiKicNgNHwsoMxQxeLnZxkps/GoB9Hwoa1Y=";
    };
    vendorHash = "sha256-L/vi1hDMycpX48QktREdhn8fkVYIqhfu3Cq4kvli0zs=";
    ldflags = [
      "-s"
      # version should not be specified
      # https://github.com/termkit/gama/blob/5063d35e48f3118fa793965fcbb931ef3b330f02/main.go#L20
    ];
  }
)
