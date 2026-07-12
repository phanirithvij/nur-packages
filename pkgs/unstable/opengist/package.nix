{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.14.0-unstable-2026-07-21";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "c7fe438feb4276fde526526305ff412ef2cc70e5";
    hash = "sha256-glKhgETje+TRmwnSWJ+fVla0hsyljZLnRKcM4xi+zQ8=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "opengist-frontend-${version}-npm-deps";
      hash = "sha256-Zz6qoqTV/O73OrBL7ry1VXK9nF6Eb6QeqcefLpyMN1c=";
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
    vendorHash = "sha256-J4JMOCj7S8N0kX7VBZmrAiPuXjWur+MIkS8pMVmkLbs=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
