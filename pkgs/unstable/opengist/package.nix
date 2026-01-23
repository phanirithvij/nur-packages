{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.11.1-unstable-2026-01-21";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "a17effb10fe3c4e1a05375eb6544948abb47a609";
    hash = "sha256-MAhdT95le9A2/CtRqOrVYRffiOL+jEgmhgFEik0/8Uc=";
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
    vendorHash = "sha256-gM5n+Cf7x+Ik5sbQWBHLa67QSQOG6APNJVGVzkfdszw=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
