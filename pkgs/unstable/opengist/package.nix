{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.13.1-unstable-2026-06-27";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "cc03c1e91041859f69ea403b921b15fb90f27272";
    hash = "sha256-3S8FYhUGKMiRBfbn4F+S6NETOrGdlehsgzpQGpG5c0A=";
  };
  # TODO,BUG: ./scripts/update.sh for this package causes frontend.npmDeps.hash to be set in goModules.vendorHash
  # And the goModules.vendorHash is not being computed
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "opengist-frontend-${version}-npm-deps";
      hash = "sha256-6W5MRFFMpYphSf5Uj2XMF0wL9f/AhDbGIZ6u17rb2R8=";
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
    vendorHash = "sha256-gYtbQGXX1Dg4DQafEiVqqlWgsFk/WchSc8eMW9/c7r4=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
      substituteInPlace go.mod --replace-fail "go 1.26.4" "go 1.26.3"
    '';
  }
)
