{
  fetchFromGitHub,
  gama-tui,
}:
gama-tui.overrideAttrs (
  finalAttrs: _: {
    version = "main";
    src = fetchFromGitHub {
      owner = "termkit";
      repo = "gama";
      rev = "refs/heads/${finalAttrs.version}";
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
