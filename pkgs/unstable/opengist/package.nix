{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.9.1-unstable-2025-04-06";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "b82b3d9e0e3c585089d90b847c36f32144447133";
    hash = "sha256-qm3pK0TFuNqg2b34n1dBuOt4qh1xrxAMH5ZveSfpbyM=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-Uh+oXd//G/lPAMXRxijjEOpQNmeXK/XCIU7DJN3ujaY=";
    };
  };
in
opengist.overrideAttrs (
  finalAttrs: _: {
    inherit version src;
    vendorHash = "sha256-m2f9+PEMjVhlXs7b1neEWO0VY1fQSfe+T1aNEdtML28=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{manifest.json,assets} public/
    '';
  }
)
