# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

let
  flake-inputs = import (fetchTarball {
    url = "https://github.com/fricklerhandwerk/flake-inputs/tarball/4.1.0";
    sha256 = "1j57avx2mqjnhrsgq3xl7ih8v7bdhz1kj3min6364f486ys048bm";
  });
  inherit (flake-inputs) import-flake;
in
{
  flake ? import-flake { src = ./.; },
  sources ? flake.inputs,
  nixpkgs ? sources.nixpkgs,
  config ? { }, # allows --arg config from cli
  overlays ? [ ],
  system ? builtins.currentSystem,
  pkgs ? import nixpkgs {
    inherit
      config
      overlays
      system
      ;
  },
  lib ? import "${nixpkgs}/lib",
}:
let
  # Should allow deps to be discovered without explicitly passing them around
  # only scope to self' which is the by-name scope, do not scope to self
  callPackage = pkgs.newScope (self' // { inherit callPackage; });

  pkgsByName = import ./pkgs/by-name { inherit callPackage lib; };
  self' = pkgsByName;

  self = self' // {
    # The `lib`, `modules`, and `overlays` names are special
    lib = lib.extend (_: _: import ./lib { inherit pkgs lib; }); # functions
    modules = import ./modules; # nixos/hm modules
    overlays = import ./overlays; # nixpkgs overlays

    # patched pkgs
    # has some customisations applied to orignal packages
    # primarily useful to have these rebuilt via gha+cachix
    # nh = callPackage ./pkgs/patched/nh { inherit (self.flakePkgs) nix-output-monitor; };
    nh = callPackage ./pkgs/patched/nh { };
    bashmount = callPackage ./pkgs/patched/bashmount { };
    bluetuith = callPackage ./pkgs/patched/bluetuith { };
    pr-tracker = callPackage ./pkgs/patched/pr-tracker { };
    gitbatch = callPackage ./pkgs/patched/gitbatch { };

    # cached packages
    # push em to cachix/oranc binary caches
    # ideally: some belong to patched pkgs
    # btw no need to use these inside system config, they are mainly for ci.nix
    hplip = callPackage ./pkgs/cached/hplip.nix { };
    linux-firmware-iron-zstd = callPackage ./pkgs/cached/linux-firmware-iron.nix { };
    nvidia-settings = callPackage ./pkgs/cached/nvidia-settings.nix { };

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

    devShells.default =
      (import (sources.devshell-lib + "/lib/devshells.nix") {
        name = "nur";
        inherit pkgs;
        enableTreefmt = false;
        tools = with pkgs; [
          # dprint # TODO enableTreefmt
          nixfmt
          sources.nix-update.packages.${system}.default
        ];
        packages = [ ]; # these don't show up in menu
        extraCommands = [ ]; # should be in the format list of attrs devshell expects
        devshell = import sources.devshell { nixpkgs = pkgs; };
      }).shell.overrideAttrs # devshell is a `derivation` which has no overrideAttrs (it is an stdenv.mkdrv thing)
        (o: {
          name = "nur";
          shellHook = o.shellHook;
        });
  };
in
self
