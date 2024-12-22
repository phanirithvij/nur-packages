{
  fetchFromGitHub,
  opengist,
}:
let
  version = "master";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "refs/heads/${version}";
    hash = "sha256-vpl3ztLHeVZndAwDgobfiI+3Xu3CFU38qgXy83p06As=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDepsHash = "sha256-l09TPGBGhWcsl3x14ovilDd1zZWv4XzFCAmAfapKtAE=";
  };
in
opengist.overrideAttrs (
  finalAttrs: _: {
    inherit version src;
    vendorHash = "sha256-mLFjRL4spAWuPLVOtt88KH+p2g9lGCYzaHokVxdrLOw=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{manifest.json,assets} public/
    '';
  }
)
