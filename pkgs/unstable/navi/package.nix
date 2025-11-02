{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.25.0-beta1-unstable-2025-08-18";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "b01291e04041ea617de8d9ee7be628e4ac64e241";
      hash = "sha256-v5f44YmXlBIYe7OiVWxt44BQ3Jejt5AcWn/DhtAAfro=";
    };
  in
  {
    inherit pname version src;
    # https://discourse.nixos.org/t/nixpkgs-overlay-for-mpd-discord-rpc-is-no-longer-working/59982/2
    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-DUbCcHNCEMDjiYeghDdj2uJeQoHzjKKNMQ1SotEEyy4=";
    };
  }
)
