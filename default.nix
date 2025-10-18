# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  sources ? import ./npins,
  nixpkgs ? sources.nixpkgs,
  pkgs ? import nixpkgs { },
  system ? builtins.currentSystem,
}:
let
  inherit (pkgs) lib callPackage;
in
{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  feedpushr = callPackage ./pkgs/feedpushr { };
  goagen_1 = callPackage ./pkgs/goagen_1 { };
  qbittorrentui = callPackage ./pkgs/qbittorrentui { };
  bluetuith = callPackage ./pkgs/patched/bluetuith { };
  bashmount = callPackage ./pkgs/patched/bashmount { };
  starship = callPackage ./pkgs/patched/starship { };

  # These are flakes, but
  #   I don't want to pollute my system flake
  #   don't want to write a lot of inputs.*.follows to avoid 10000 nixpkgs problem
  #   don't want to break packages by overriding nixpkgs.follows
  #   utilise cachix cache + gha to avoid building from source
  # having them here gives a lot of benefits
  # only downside is not being able to use homeModules, nixosModules if any, this doesn't apply to most packages
  flakePkgs =
    (lib.packagesFromDirectoryRecursive {
      inherit callPackage;
      directory = ./pkgs/flakePkgs;
    })
    // {
      recurseForDerivations = true;
    };

  # these are already in nixpkgs, and I track their unstable versions
  # to detect any early breakages
  unstablePkgs =
    (lib.packagesFromDirectoryRecursive {
      inherit callPackage;
      directory = ./pkgs/unstable;
    })
    // {
      recurseForDerivations = true;
    };

  # overlayPkgs, force overlays to be built in ci
  overlayPkgs = (import ./overlays/overlayPkgs.nix { inherit system nixpkgs; }) // {
    recurseForDerivations = true;
  };
}
