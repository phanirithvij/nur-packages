{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.11.1-unstable-2025-12-28";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "22376d6cd3d2dce420b6ca7f35ad1b2c8cb33785";
    hash = "sha256-INjI98YKPoIgDefmMovDhQ1i6ZRrUfZqY3mjsEBojsw=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-EZseT0HZo1i/hZ3JVVMQweAJFv6UFXxUGjqxFjWEoUE=";
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
    vendorHash = "sha256-6OvMPGeeXcDpGegGU0Ul/niXM/8MNOKH9aU5uDJf2R8=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
