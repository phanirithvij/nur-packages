{
  description = "My personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-update.url = "github:Mic92/nix-update";
    nix-update.inputs.nixpkgs.follows = "nixpkgs";
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
      ];
      forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems f;
      # https://github.com/nix-community/nur-packages-template/issues/89
      pkgs = forAllSystems (system: inputs.nixpkgs.legacyPackages."${system}");
    in
    {
      legacyPackages = forAllSystems (
        system:
        import ./default.nix {
          pkgs = pkgs.${system};
          inherit (inputs) nixpkgs;
          inherit system;
        }
      );
      packages = forAllSystems (
        system:
        (inputs.nixpkgs.lib.filterAttrs (
          _: v: inputs.nixpkgs.lib.isDerivation v
        ) self.legacyPackages.${system})
        // {
          inherit (self.legacyPackages.${system}) unstablePkgs flakePkgs;
        }
      );
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = with pkgs.${system}; [
            nixfmt-rfc-style
            dprint
            inputs.nix-update.packages.${system}.default
          ];
        };
        overlayShell = import ./overlays/test-shell.nix {
          inherit (inputs) nixpkgs;
          inherit system;
        };
      });
    };
}
