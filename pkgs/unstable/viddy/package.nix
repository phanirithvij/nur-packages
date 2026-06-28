{
  fetchFromGitHub,
  rustPlatform,
  viddy,
}:
viddy.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "1.3.1-unstable-2026-06-14";
    src = fetchFromGitHub {
      owner = "sachaos";
      repo = "viddy";
      rev = "eee2ff2c104b16c242b3190ba2bc65bb031580dc";
      hash = "sha256-RyPG8OAg3i9N2Fq5Hij48wMvfQuTNmJFpatvB3HbXKg=";
    };
    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-P+TtxV2kuHeBHr8GQeJ0VWPkjimfcAtBUFt0z79ML6A=";
    };
    preBuild = (oldAttrs.preBuild or "") + ''
      substituteInPlace Cargo.toml \
        --replace-fail "version = \"${oldAttrs.version}\"" "version = \"${finalAttrs.version}\""
    '';
  }
)
