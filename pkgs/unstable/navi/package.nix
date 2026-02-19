{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.25.0-beta1-unstable-2026-02-20";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "ae0c475fc4f76e49a58b4ec8b76cc293cdb187d2";
      hash = "sha256-F7rACxjZEWeiLCaCpj5apFMQG/rXvR/lzOEu8NvFCwE=";
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
