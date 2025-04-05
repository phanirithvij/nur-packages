# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  nixpkgs ? <nixpkgs>,
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

  feedpushr = callPackage ./pkgs/feedpushr { inherit pkgs; };
  git-history = callPackage ./pkgs/git-history { };
  goagen_1 = callPackage ./pkgs/goagen_1 { };
  qbittorrentui = import ./pkgs/qbittorrentui { inherit pkgs; };
  tgrclone = callPackage ./pkgs/tgrclone.nix { };
  nix-schema = import ./pkgs/nix-schema.nix;
  neovim-nvf = import ./pkgs/neovim-nvf-flake.nix { inherit pkgs; };

  # these are already in nixpkgs, and I track their unstable versions
  # to detect any early breakages
  unstablePkgs = lib.packagesFromDirectoryRecursive {
    inherit callPackage;
    directory = ./pkgs/unstable;
  };

  # overlayShell, a drv which forces overlays to be built in ci
  overlayShell = import ./overlays/test-shell.nix { inherit system nixpkgs; };
}
