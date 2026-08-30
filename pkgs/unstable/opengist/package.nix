{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.15.2-unstable-2026-08-30";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "5afef9ac76d2d69ba11a888bb7a095b1d14e7c9d";
    hash = "sha256-yXd/6nhyRjbCdnlC5/CPMnO2zTsUAD6BupGMgebzQd0=";
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
