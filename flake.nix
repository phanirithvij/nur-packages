{
  description = "My personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-update.url = "github:Mic92/nix-update";
    nix-update.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-update,
    }:
    let
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
      pkgs = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      legacyPackages = forAllSystems (
        system:
        import ./default.nix {
          pkgs = pkgs.${system};
        }
      );
      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );
      devShells = forAllSystems (system: rec {
        pkgs' = pkgs.${system};
        default = pkgs'.mkShellNoCC {
          packages = with pkgs'; [
            nixfmt-rfc-style
            dprint
            nix-update.packages.${system}.default
          ];
        };
      });
    };
}
