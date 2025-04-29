#shellcheck shell=bash
#  generated and modified
#
#  nix eval --impure --json --expr \
#    "builtins.attrNames (import ./default.nix { })" \
#    | jq '.[]' -r \
#    | xargs -n1 echo nix-update

nix-update --commit feedpushr --version=branch
#nix-update --commit goagen_1
nix-update --commit qbittorrentui --version=branch

# nix-schema
rev="$(nix eval --expr '(builtins.getFlake "github:DeterminateSystems/nix-src/flake-schemas").rev' --refresh --impure --raw)"
sed -r "s/nix-src\/\b[0-9a-f]{5,40}\b/nix-src\/$rev/g" -i pkgs/flakePkgs/nix-schema.nix

# neovim-nvf
rev="$(nix eval --expr '(builtins.getFlake "github:NotAShelf/nvf/main").rev' --refresh --impure --raw)"
sed -r "s/nvf\/\b[0-9a-f]{5,40}\b/nvf\/$rev/g" -i pkgs/flakePkgs/neovim-nvf.nix

# nixpkgs-track
rev="$(nix eval --expr '(builtins.getFlake "github:uncenter/nixpkgs-track/main").rev' --refresh --impure --raw)"
sed -r "s/nixpkgs-track\/\b[0-9a-f]{5,40}\b/nixpkgs-track\/$rev/g" -i pkgs/flakePkgs/nixpkgs-track.nix

# hover-rs
rev="$(nix eval --expr '(builtins.getFlake "github:viperML/hover-rs/master").rev' --refresh --impure --raw)"
sed -r "s/hover-rs\/\b[0-9a-f]{5,40}\b/hover-rs\/$rev/g" -i pkgs/flakePkgs/hover-rs.nix
