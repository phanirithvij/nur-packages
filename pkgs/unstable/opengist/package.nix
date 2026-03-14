{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.12.1-unstable-2026-03-13";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "ec26888487dc5c26f6316750b7e114ac1ed98c80";
    hash = "sha256-9X7FiTg6Eialv7VNeajzK4DQs9iWRbnUziL91051F8I=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-blC6wUD/xMLm9JE8eEht0cRbMhSYaJjY9Vx/ML4lOr8=";
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
    vendorHash = "sha256-SapCdbATu1hnNFyrgPOZBNcD/In1yPz3Ys9HjzqaUPc=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
