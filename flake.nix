{
  description = "My personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-update = {
      url = "github:Mic92/nix-update";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell-lib = {
      url = "github:phanirithvij/nix-shell-templates/main";
      flake = false;
    };
  };
  outputs =
    {
      self,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems f;
      # https://github.com/nix-community/nur-packages-template/issues/89
      pkgs' = forAllSystems (system: inputs.nixpkgs.legacyPackages."${system}");
      getLegacyPkgs =
        {
          system,
          pkgs ? pkgs'.${system},
        }:
        import ./default.nix {
          inherit pkgs;
          inherit (inputs) nixpkgs;
          inherit system;
        };
      getPackages =
        {
          system,
          lib ? inputs.nixpkgs.lib,
          legacyPackages ? self.legacyPackages.${system},
        }:
        (lib.filterAttrs (_: v: lib.isDerivation v) legacyPackages)
        // {
          inherit (legacyPackages) unstablePkgs flakePkgs devShells;
          # inherit ... overlayPkgs;
          # ci.nix reads from default.nix so no need to expose overlayPkgs in flake
        };
    in
    {
      # Allows overriding pkgs, which allows specifying custom nixpkgs config to this instance of pkgs
      # eg. allowUnfreePredicate in my system flake
      lib.getNurPkgs =
        { pkgs, system, ... }:
        rec {
          legacyPackages = getLegacyPkgs { inherit pkgs system; };
          packages = getPackages {
            inherit system legacyPackages;
            inherit (pkgs) lib;
          };
        };
      legacyPackages = forAllSystems (system: getLegacyPkgs { inherit system; });
      packages = forAllSystems (system: getPackages { inherit system; });
      devShells = forAllSystems (system: self.packages.${system}.devShells);
    };
}
