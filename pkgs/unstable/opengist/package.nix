{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.10.0-unstable-2025-08-14";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "a7a25c4100d6c750e2717eb7d17e884a6cae393b";
    hash = "sha256-BRJPdAtvOVaA9yazHyvojNU0KdR3Ng5onStReUncBZk=";
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
