{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.10.0-unstable-2025-09-15";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "53ce41e0e489a6570061d213903c3f487f0605ae";
    hash = "sha256-R63j9ubx/nOO2bk9RHOcwRhz90Q/6dYJPeuaRDEZQ2o=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-2p+eq3Emc30R15wweVgOrsELGQ0XRU+0rAUNh6pW1Hw=";
    };
  };
in
opengist.overrideAttrs (
  finalAttrs: _: {
    inherit version src frontend;
    vendorHash = "sha256-NGRJuNSypmIc8G0wMW7HT+LkP5i5n/p3QH8FyU9pF5w=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{manifest.json,assets} public/
    '';
  }
)
