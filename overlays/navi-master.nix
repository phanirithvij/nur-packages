_: p: {
  navi = p.navi.overrideAttrs (
    old:
    let
      pname = "navi";
      version = "master";
      src = p.fetchFromGitHub {
        owner = "denisidoro";
        repo = "navi";
        rev = "refs/heads/${version}";
        hash = "sha256-BhOTNd7gp7PaN2GR0QOBblLoOUhZip7yB+kH0bm1sz0=";
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
