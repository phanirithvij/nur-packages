{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.10.0-unstable-2025-08-28";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "905276f24b915eb998aa6d7a759f34b68ebda4d6";
    hash = "sha256-ZOLZ9nCiSCBnuaEEuOi0r0zNlidbN1RpWIV6ITZVflI=";
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
