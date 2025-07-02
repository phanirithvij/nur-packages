#!/usr/bin/env bash
script=$(nix eval --impure --json --expr \
        "builtins.attrNames (import ./default.nix { }).unstablePkgs" |
        jq '.[]' -r |
        xargs -I{} echo nix-update --version=branch unstablePkgs.{})

eval "$script"
