#  generated and modified
#
#  nix eval --impure --json --expr \
#    "builtins.attrNames (import ./default.nix { })" \
#    | jq '.[]' -r \
#    | xargs -n1 echo nix-update

nix-update --commit distrobox-tui --version=branch=dev
nix-update --commit feedpushr --version=branch
#nix-update --commit goagen_1
nix-update --commit jampack --version=branch
nix-update --commit qbittorrentui
nix-update --commit rsshub --version=branch
