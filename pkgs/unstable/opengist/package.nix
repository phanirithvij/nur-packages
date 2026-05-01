{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.12.2-unstable-2026-04-30";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "f3c38ddbbbccf7523363419a85ebe26459171253";
    hash = "sha256-98dhLTiZRWq9WubRWqWDWWbu9nt6n1xwaPfWiHQZtxI=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-KDdXBE5X+fOuXF/hIkyRHscMmBQ/E0PCUednfEm5i8k=";
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
    vendorHash = "sha256-lhDga5shastI7BfnEnekFnUc2L8Ju6LazeqvD7+CK/o=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
