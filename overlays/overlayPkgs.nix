{
  nixpkgs ? <nixpkgs>,
  system ? builtins.currentSystem,
}:
let
  overlayMap = import ./.;
  overlays = builtins.attrValues overlayMap;
  pkgs = import nixpkgs {
    inherit overlays system;
  };
  inherit (pkgs) lib;
  # TODO warn any unmatched names
  # must match to pkgs
  overlayNames = map (n: lib.removeSuffix "-overlay" n) (builtins.attrNames overlayMap);
in
lib.listToAttrs (
  map (n: {
    name = n;
    value = pkgs.${n};
  }) overlayNames
)
