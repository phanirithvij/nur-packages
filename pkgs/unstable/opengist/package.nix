{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.11.1-unstable-2025-10-31";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "3957dfb3ea27d3ce84b9295f28b46c55b18db7cd";
    hash = "sha256-rQgaRDN4JAkWqPg551J/M9VokTWqED5IgufY8eZEwt0=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-4ICKVVQMCtMG+Gjz9TZISXirZ22GgQZAMuD2tZCEvxs=";
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
    vendorHash = "sha256-DfKrYyZ7zqtt+GsMvYHI/nhQCFFGoRBCxbD2TaPpijs=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
