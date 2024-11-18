#  generated and modified
#
#  nix eval --impure --json --expr \
#    "builtins.attrNames (import ./default.nix { })" \
#    | ${jq}/bin/jq '.[]' -r \
#    | xargs -n1 echo nix-update

nix-update --commit distrobox-tui --version=branch=dev
nix-update --commit feedpushr --version=branch
nix-update --commit gama --version=branch
#nix-update --commit goagen_1
nix-update --commit gocovsh
nix-update --commit golds
nix-update --commit gtrash
nix-update --commit jampack --version=branch
nix-update --commit pkgsite --version=branch
nix-update --commit pik
nix-update --commit qbittorrentui
nix-update --commit rsshub --version=branch
nix-update --commit tcount --version=branch
