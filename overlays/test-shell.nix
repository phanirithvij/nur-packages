# A simple way to ensure all overlays build
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
pkgs.mkShellNoCC {
  packages = map (pkg: if builtins.isFunction pkg then pkg { } else pkg) (
    map (n: pkgs.${n}) overlayNames
  );
}
