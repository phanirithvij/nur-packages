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
      hash = "sha256-eTRK2p75ny/Psjq8jLbLMeyYJs1ZfijSt4eeu/0pAxo=";
    };
    vendorHash = "sha256-PTyrSXLMr244+ZTvjBBUc1gmwYXBAs0bXZS2t3aSWFQ=";
    ldflags = [
      "-s"
      # version should not be specified
      # https://github.com/termkit/gama/blob/5063d35e48f3118fa793965fcbb931ef3b330f02/main.go#L20
    ];
  }
)
