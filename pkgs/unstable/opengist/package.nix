{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.10.0-unstable-2025-08-01";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "bb1991f3caa292eb8a218d6c51f5f4f44cb0a190";
    hash = "sha256-ej62unjpjBFkuk++q/anCzTNtp0YrfbiRyxk/6ddFCU=";
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
