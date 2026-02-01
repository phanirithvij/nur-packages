{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.12.0-unstable-2026-01-31";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "b7278b60abebffb1bff1cd7707c20f964454d44b";
    hash = "sha256-SL9rkpwpGF0eSqJVTXvdpdSzzIZ/ngvedWqPimBg70A=";
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
