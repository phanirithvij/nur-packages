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
      hash = "sha256-KAhNK3PpaV8eoXpzo6n4NLS9NgyIp+MX7WY8v/Qih1I=";
    };
    vendorHash = "sha256-F7X3FBM/F0uPxbM3en0sk9a58O/meKnVsASgIlL7FCo=";
  }
)
