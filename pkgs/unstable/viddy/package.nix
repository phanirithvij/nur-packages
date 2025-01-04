{
  lib,
  fetchFromGitHub,
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
    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (
      lib.const {
        inherit (finalAttrs) src;
        outputHash = "sha256-d/wmjvbTITpcGCrMVZrkUcCFPDdas2CDDPlIqoVBl9k=";
      }
    );
  }
)
