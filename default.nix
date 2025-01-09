# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  nixpkgs ? <nixpkgs>,
  pkgs' ? import nixpkgs { },
  pkgs ? import (pkgs'.applyPatches {
    src = nixpkgs;
    patches = [ ./tinyexr-nixpkgs.patch ];
  }) { },
  system ? builtins.currentSystem,
}:
let
  inherit (pkgs) lib callPackage recurseIntoAttrs;
in
rec {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  feedpushr = callPackage ./pkgs/feedpushr { inherit pkgs; };
  goagen_1 = callPackage ./pkgs/goagen_1 { };
  jampack = callPackage ./pkgs/jampack.nix { };
  qbittorrentui = import ./pkgs/qbittorrentui { inherit pkgs; };
  rsshub = callPackage ./pkgs/rsshub { };
  tgrclone = callPackage ./pkgs/tgrclone.nix { };
  nix-schema = import ./pkgs/nix-schema.nix;
  vliv = recurseIntoAttrs (callPackage ./pkgs/vliv { vliv = vliv.base; });
  # vliv32 = vliv.override { }; # TODO figure out args, also rec?

  # these are already in nixpkgs, and I track their unstable versions
  # to detect any early breakages
  unstablePkgs = lib.packagesFromDirectoryRecursive {
    inherit callPackage;
    directory = ./pkgs/unstable;
  };

  # overlayShell, a drv which forces overlays to be built in ci
  overlayShell = import ./overlays/test-shell.nix { inherit system nixpkgs; };
}
