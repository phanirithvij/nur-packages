{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.10.0-unstable-2025-07-01";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "b18cdb9188cea74ff159b657bbbb1c304b00cd24";
    hash = "sha256-/K60Zg+O133msA1iM7tRCNcqMeKR4oRoJnQKz0ws5J8=";
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
    vendorHash = "sha256-kaP6x1K7BVZ/Rg/5gG4Br7gIllLxovcY7iFpRIlJHRs=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{manifest.json,assets} public/
    '';
  }
)
