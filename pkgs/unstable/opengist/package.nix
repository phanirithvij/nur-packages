{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.15.3-unstable-2026-10-21";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "2acf3dae87f9c3d536e0a870787941bbd06d0b46";
    hash = "sha256-tDmWv3Tsfgskn94RGrREBLyOJir2+OuCo7M7qXSOcZ8=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "opengist-frontend-${version}-npm-deps";
      hash = "sha256-9MqW3K2LxNXbB/+A8N8kDkBW5+KZHisOtfqJHqcJ4dQ=";
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
    vendorHash = "sha256-7YbKUeV+Lm7D/5jIqVm71EnRL4FDFops9c8zTXQMS1Y=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
