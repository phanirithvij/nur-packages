{
  fetchFromGitHub,
  rustPlatform,
  viddy,
}:
viddy.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "1.3.1-unstable-2026-08-16";
    src = fetchFromGitHub {
      owner = "sachaos";
      repo = "viddy";
      rev = "b56efe0876f255ade025d6b77fb9f3f30099675b";
      hash = "sha256-NY0W6bSm2ziAXOzLN5suiZold+my8aUI3syxxkASYFM=";
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
