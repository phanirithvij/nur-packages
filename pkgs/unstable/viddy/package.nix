{
  fetchFromGitHub,
  rustPlatform,
  viddy,
}:
viddy.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "1.3.0-unstable-2024-12-23";
    src = fetchFromGitHub {
      owner = "sachaos";
      repo = "viddy";
      rev = "ad1f0fede51814634e6ab1ba84911c09b42953d2";
      hash = "sha256-uHI55dwAK9gGfONrJW6tUnyi/PhLYVk22TfQJBCYKzo=";
    };
    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-Bp3t/fjaFeouIoKlRvQPVDlc46Ggitfx6HUXE+RZN0A=";
    };
  }
)
