{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.12.1-unstable-2026-02-25";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "42490f2995b106c5f2cf3b5b07ff2f92855cd93c";
    hash = "sha256-jLt9LzB62D5olhssBcGneln5ga52MZV7qEZPlnOuoPM=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-wjGtA99Cn9FtUbYqhoagDzeuQkc9vKwHsJKI2j+ZgMc=";
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
    vendorHash = "sha256-rRT4SDKtQhLWl1K+DodXO4BBK2SEeJzUph3su306GWU=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
