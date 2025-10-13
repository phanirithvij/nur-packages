{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.11.1-unstable-2025-10-07";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "8129906b0218f35c4113d368a7961bd4d1f773cb";
    hash = "sha256-/aHYfZ56Pv2XCuzqzwpcYw3lyNnxfnfUfBVhwWCEP4c=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-4ICKVVQMCtMG+Gjz9TZISXirZ22GgQZAMuD2tZCEvxs=";
    };
  };
in
opengist.overrideAttrs (
  finalAttrs: _: {
    inherit version src frontend;
    vendorHash = "sha256-4ICKVVQMCtMG+Gjz9TZISXirZ22GgQZAMuD2tZCEvxs=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{manifest.json,assets} public/
    '';
  }
)
