{
  fetchFromGitHub,
  fetchNpmDeps,
  opengist,
}:
let
  pname = "opengist";
  version = "1.12.1-unstable-2026-03-08";
  src = fetchFromGitHub {
    owner = "thomiceli";
    repo = "opengist";
    rev = "f8b3bbce6a596a2ca8810a9b404fcbac4a79d68b";
    hash = "sha256-8A8F+kMjdliWAsVL/mvZ8yX+xz3dhuhSvMf9PxpuDnY=";
  };
  frontend = opengist.frontend.overrideAttrs {
    inherit version src;
    npmDeps = fetchNpmDeps {
      inherit src;
      name = "${pname}-frontend-${version}-npm-deps";
      hash = "sha256-s7q42y0PS54OFlXMUoB6arfyXqR2SL7Ykhzbx0UaPxA=";
    };
    # Remove postcss step because it was removed upstream
    # see
    # https://github.com/thomiceli/opengist/commit/f653179cbf435cbba67e6cce51952c3a3a608381#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52L22-R38
    postBuild = "";
  };
in
opengist.overrideAttrs (
  finalAttrs: _: {
    inherit version src frontend;
    vendorHash = "sha256-Y6J71r7GdIwH2XHFvdGFhozOt7H9dgnt+CjTCMQO4MM=";
    ldflags = [
      "-s"
      "-X github.com/thomiceli/opengist/internal/config.OpengistVersion=${finalAttrs.version}"
    ];
    postPatch = ''
      cp -R ${frontend}/public/{.vite,assets} public/
    '';
  }
)
