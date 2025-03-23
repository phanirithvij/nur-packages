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
      hash = "sha256-i42gTPz0oVxz7VbP+wXKhmqmpAsmMApiVopWYDhDrzs=";
    };
    vendorHash = "sha256-y64KqlJsZ8aVK7oBcduEC8VvbutoRC15LMUeZdokPfY=";
  }
)
