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
    hash = "sha256-Zjn38OGnDtgD2OfIhgUxWo0Cx+ZmNv6UjJanASbjiYU=";
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
