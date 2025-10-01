{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.11.1-unstable-2025-09-30";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "f0a596aed07f8f7fae32e8d85a3fa640a956b825";
    hash = "sha256-TlUaen8uCj4Ba2gOWG32Gk4KIDvitXai5qv4PTeizYo=";
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
