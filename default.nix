# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs) callPackage;
in
{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  distrobox-tui = callPackage ./pkgs/distrobox-tui.nix { };
  feedpushr = callPackage ./pkgs/feedpushr { inherit pkgs; };
  gama = callPackage ./pkgs/gama.nix { };
  goagen_1 = callPackage ./pkgs/goagen_1 { };
  gocovsh = callPackage ./pkgs/gocovsh.nix { };
  golds = callPackage ./pkgs/golds { };
  gtrash = callPackage ./pkgs/gtrash.nix { };
  jampack = callPackage ./pkgs/jampack.nix { };
  pik = callPackage ./pkgs/pik.nix { };
  pkgsite = callPackage ./pkgs/pkgsite.nix { };
  qbittorrentui = import ./pkgs/qbittorrentui { inherit pkgs; };
  rsshub = callPackage ./pkgs/rsshub { };
  tcount = callPackage ./pkgs/tcount.nix { };
  ufetch = (callPackage ./pkgs/ufetch { }).override { full = false; };
}
