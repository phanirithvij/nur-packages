_: p: {
  navi = p.navi.overrideAttrs (
    old:
    let
      pname = "navi";
      version = "2.25.0-beta1-unstable-2025-06-30";
      src = p.fetchFromGitHub {
        owner = "denisidoro";
        repo = "navi";
        rev = "c6da2d934d0cf5e528d90567fe466845bc1c9223";
        hash = "sha256-M8rqt7uBVZxtINWsYDEoIe+Mr5mZfCRYpQJTYWCVO6A=";
      };
    in
    {
      inherit pname version src;
      # https://discourse.nixos.org/t/nixpkgs-overlay-for-mpd-discord-rpc-is-no-longer-working/59982/2
      cargoDeps = p.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-DUbCcHNCEMDjiYeghDdj2uJeQoHzjKKNMQ1SotEEyy4=";
      };
    }
  );
}
