{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.25.0-unstable-2026-04-03";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "f1463e9e7ba5b87cc2d32511fab47317c2fbe58c";
      hash = "sha256-E/GYAmyrXmOSFHvR/8FIBIlget87uwT2xl8/AvfXvfQ=";
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
