{
  fetchFromGitHub,
  opengist,
  lib,
}:
let
  version = "master";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "refs/heads/${version}";
    hash = "sha256-sHUYmft08bNqyXyTJdZBX4YxpdQXJy3juL0YgfAy7MM=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDepsHash = lib.fakeHash;
  };
in
opengist.overrideAttrs (
  finalAttrs: _: {
    inherit version src;
    vendorHash = lib.fakeHash;
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{manifest.json,assets} public/
    '';
  }
)
