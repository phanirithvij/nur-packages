{
  fetchFromGitHub,
  distrobox-tui,
}:
distrobox-tui.overrideAttrs (
  finalAttrs: _: {
    version = "master";
    src = fetchFromGitHub {
      owner = "phanirithvij";
      repo = "distrobox-tui";
      rev = "refs/heads/${finalAttrs.version}";
      hash = "sha256-W20sXe85OX3dc5Z/kibTOC1fB71l3elVh6XxydVs+Nc=";
    };
    vendorHash = "sha256-zKJrhR/l2HPQXTVgrxYLGGz0pjA0e81jB6H4YrNfH94=";
  }
)
