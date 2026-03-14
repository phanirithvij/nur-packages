{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.24.0-unstable-2026-03-14";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "b4ce885253df0b262332538a5561b458fe5dd3a2";
      hash = "sha256-sjlZDiK7b1UEdgJHPgtbU8oTP2z+Kn6Uk/+DSjLCGFs=";
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
