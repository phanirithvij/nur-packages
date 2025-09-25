{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.11.0-unstable-2025-09-21";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "92c556953822f731ebf800b3e5d2f53c9f4b7cc7";
    hash = "sha256-DaJWRVJtLN8NGw0/WWNrpHrRz+OBtybH7So2sO9dnb0=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-zBao/EoAolkgMvqQPqN0P2VC4tT6gkQPqIk4HyfXC7o=";
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
