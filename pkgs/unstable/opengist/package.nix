{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.15.1-unstable-2026-08-04";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "72c5696cd7257b7b7783a1a7f64d00d77280bb34";
    hash = "sha256-BOqAmQsT8MtohE/1k2YaNZv8cmruWzLur+yyNs3ARcQ=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "opengist-frontend-${version}-npm-deps";
      hash = "sha256-hAG0vGjG+ejumjoslYs/UnYBImZDNsTQUDtssT0X/HI=";
    };
    # Remove postcss step because it was removed upstream
    # see
    # https://github.com/thomiceli/opengist/commit/f653179cbf435cbba67e6cce51952c3a3a608381#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52L22-R38
    postBuild = "";
  };
in
opengist.overrideAttrs (
  finalAttrs: _: {
    inherit version src frontend;
    vendorHash = "sha256-YU1OdYM9GzUGHypgIhWvJCvYEzlKsaKGN0NZRBfT8FY=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
