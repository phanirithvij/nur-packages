{
  fetchFromGitHub,
  rustPlatform,
  viddy,
}:
viddy.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "master";
    src = fetchFromGitHub {
      owner = "sachaos";
      repo = "viddy";
      rev = "refs/heads/${finalAttrs.version}";
      hash = "sha256-uHI55dwAK9gGfONrJW6tUnyi/PhLYVk22TfQJBCYKzo=";
    };
    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-Bp3t/fjaFeouIoKlRvQPVDlc46Ggitfx6HUXE+RZN0A=";
    };
  }
)
