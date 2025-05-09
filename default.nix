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
  # TODO re-enable later
  # see https://discord.com/channels/568306982717751326/570351733780381697/1358729732241489971
  # nix-schema = import ./pkgs/flakePkgs/nix-schema.nix { inherit system; };
  neovim-nvf = import ./pkgs/flakePkgs/neovim-nvf.nix { inherit pkgs system; };
  nixpkgs-track = import ./pkgs/flakePkgs/nixpkgs-track.nix { inherit system; };
  hover-rs = import ./pkgs/flakePkgs/hover-rs.nix { inherit system; };

  # these are already in nixpkgs, and I track their unstable versions
  # to detect any early breakages
  unstablePkgs = lib.packagesFromDirectoryRecursive {
    inherit callPackage;
    directory = ./pkgs/unstable;
  };

  # overlayShell, a drv which forces overlays to be built in ci
  overlayShell = import ./overlays/test-shell.nix { inherit system nixpkgs; };
}
