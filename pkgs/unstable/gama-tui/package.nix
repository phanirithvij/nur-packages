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
      hash = "sha256-2uZFDBsDF/nFnTIBrSDLr//J1rporkgjjzUYkZoKZgo=";
    };
    vendorHash = "sha256-U8D3o7KC62mo0Z2877gllgDY21zo8Vty4zILrwpWTdY=";
    ldflags = [
      "-s"
      # version should not be specified
      # https://github.com/termkit/gama/blob/5063d35e48f3118fa793965fcbb931ef3b330f02/main.go#L20
    ];
  }
)
