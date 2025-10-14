{
  description = "My personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-compat.url = "github:edolstra/flake-compat";
    nix-update.url = "github:Mic92/nix-update";
    nix-update.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems f;
      # https://github.com/nix-community/nur-packages-template/issues/89
      pkgs = forAllSystems (system: inputs.nixpkgs.legacyPackages."${system}");

      # this used to be in default.nix with default args for pkgs, nixpkgs, and system
      # but now using flake-compat, to pin nixpkgs version instead of relying on npins or <nixpkgs>
      defaultNix =
        {
          nixpkgs,
          pkgs,
          system,
        }:
        {
          # The `lib`, `modules`, and `overlays` names are special
          lib = import ./lib { inherit pkgs; }; # functions
          modules = import ./modules; # NixOS modules
          overlays = import ./overlays; # nixpkgs overlays

          feedpushr = pkgs.callPackage ./pkgs/feedpushr { };
          goagen_1 = pkgs.callPackage ./pkgs/goagen_1 { };
          qbittorrentui = pkgs.callPackage ./pkgs/qbittorrentui { };
          bluetuith = pkgs.callPackage ./pkgs/patched/bluetuith { };
          starship = pkgs.callPackage ./pkgs/patched/starship { };

          # These are flakes, but
          #   I don't want to pollute my system flake
          #   don't want to write a lot of inputs.*.follows to avoid 10000 nixpkgs problem
          #   don't want to break packages by overriding nixpkgs.follows
          #   utilise cachix cache + gha to avoid building from source
          # having them here gives a lot of benefits
          # only downside is not being able to use homeModules, nixosModules if any, this doesn't apply to most packages
          flakePkgs =
            (pkgs.lib.packagesFromDirectoryRecursive {
              inherit (pkgs) callPackage;
              directory = ./pkgs/flakePkgs;
            })
            // {
              recurseForDerivations = true;
            };

          # these are already in nixpkgs, and I track their unstable versions
          # to detect any early breakages
          unstablePkgs =
            (pkgs.lib.packagesFromDirectoryRecursive {
              inherit (pkgs) callPackage;
              directory = ./pkgs/unstable;
            })
            // {
              recurseForDerivations = true;
            };

          # overlayPkgs, force overlays to be built in ci
          overlayPkgs = (import ./overlays/overlayPkgs.nix { inherit system nixpkgs; }) // {
            recurseForDerivations = true;
          };
        };
    in
    {
      legacyPackages = forAllSystems (
        system:
        defaultNix {
          pkgs = pkgs.${system};
          inherit (inputs) nixpkgs;
          inherit system;
        }
      );
      packages = forAllSystems (
        system:
        (inputs.nixpkgs.lib.filterAttrs (
          _: v: inputs.nixpkgs.lib.isDerivation v
        ) inputs.self.legacyPackages.${system})
        // {
          inherit (inputs.self.legacyPackages.${system}) unstablePkgs flakePkgs;
          # inherit ... overlayPkgs;
          # ci.nix reads from default.nix so no need to expose overlayPkgs in flake
        }
      );
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = with pkgs.${system}; [
            nixfmt-rfc-style
            #dprint
            inputs.nix-update.packages.${system}.default
          ];
        };
      });
    };
}
