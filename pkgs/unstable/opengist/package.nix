{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.10.0-unstable-2025-08-18";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "29761736586251adc1f6aee81f49a3db9e41104c";
    hash = "sha256-NIR41dzmDy6JbH6Ssy4oPBQBjsyv7df/E+RXD8IWWFM=";
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
