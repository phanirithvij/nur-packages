#!/usr/bin/env bash
# shellcheck shell=bash
#  generated and modified
#
#  nix eval --impure --json --expr \
#    "builtins.attrNames (import ./default.nix { })" \
#    | jq '.[]' -r \
#    | xargs -n1 echo nix-update

#nix-update --commit feedpushr --version=branch
#nix-update --commit goagen_1
nix-update --commit qbittorrentui --version=branch

updateFlakePkg() {
        owner=$(echo "$1" | cut -d/ -f1)
        reponame=$(echo "$1" | cut -d/ -f2)
        branch=$(echo "$1" | cut -d/ -f3)
        filename=$2
        if [ -z "$branch" ]; then
                repo="$owner/$reponame"
        else
                repo="$owner/$reponame/$branch"
        fi
        if [ -z "$filename" ]; then
                filename="pkgs/flakePkgs/$reponame.nix"
        fi
        rev="$(nix eval --expr "(builtins.getFlake \"github:$repo\").rev" --refresh --impure --raw)"
        sed -r "s/$reponame\/\b[0-9a-f]{5,40}\b/$reponame\/$rev/g" -i "$filename"
}

# TODO for loop over dir
# need to track branch as a marker somewhere in the file ig
updateFlakePkg DeterminateSystems/nix-src/flake-schemas pkgs/flakePkgs/nix-schema.nix
updateFlakePkg viperML/hover-rs
updateFlakePkg NotAShelf/nvf/v0.8 # Temporarily move to 0.8 for NotAShelf/nvf#1172
updateFlakePkg uncenter/nixpkgs-track
updateFlakePkg euank/yaml2nix
updateFlakePkg ghostty-org/ghostty
updateFlakePkg e-tho/bzmenu
updateFlakePkg utdemir/nix-tree
updateFlakePkg Fuwn/yae
updateFlakePkg maralorn/nix-output-monitor

# unstablePkgs

script=$(nix eval --impure --json --expr \
        "builtins.attrNames (import ./default.nix { }).unstablePkgs" |
        jq '.[]' -r |
        xargs -I{} echo nix-update --version=branch unstablePkgs.{})

eval "$script"

# overlayPkgs

nix-update --version=branch overlayPkgs.git-bug
nix-update --version=branch overlayPkgs.navi
