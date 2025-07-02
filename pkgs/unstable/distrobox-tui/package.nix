{
  fetchFromGitHub,
  distrobox-tui,
}:
distrobox-tui.overrideAttrs (
  finalAttrs: _: {
    version = "0.2.0-unstable-2025-03-11";
    src = fetchFromGitHub {
      owner = "phanirithvij";
      repo = "distrobox-tui";
      rev = "472c748e39669da2a2b9aeab534858fed1c6ed70";
      hash = "sha256-i42gTPz0oVxz7VbP+wXKhmqmpAsmMApiVopWYDhDrzs=";
    };
    vendorHash = "sha256-y64KqlJsZ8aVK7oBcduEC8VvbutoRC15LMUeZdokPfY=";
  }
)
