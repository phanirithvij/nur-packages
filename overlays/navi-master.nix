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
        hash = "sha256-2RekEpAYHTqzKqlhl9dxtJU3+9QIGaQpw9H80uuubi0=";
      };
    in
    {
      inherit pname version src;
      # https://discourse.nixos.org/t/nixpkgs-overlay-for-mpd-discord-rpc-is-no-longer-working/59982/2
      cargoDeps = p.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-tQCm8KMVWo6KiKVOMDitHtDXwYGM7INXcT+7fEEiIiI=";
      };
    }
  );
}
