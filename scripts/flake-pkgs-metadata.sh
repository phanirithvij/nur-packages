#!/usr/bin/env bash
# coreutils gnugrep nix

out="$(mktemp -d -t "temp-flakepkgs-flk-XXXX")"
{
        echo "{ inputs = {"
        for f in pkgs/flakePkgs/*.nix; do
                # grep -oP '"K.*(?=")') can remove quotes, ref unix.stackexchange.com/a/13472
                flk="$(grep 'getFlake' "$f" | grep -o '".*"')"
                name="$(echo "$flk" | cut -d'/' -f2)"
                echo "$name.url = $flk;"
        done
        echo "}; outputs = _: {}; }"
} >"$out/flake.nix"

pushd "$out" >/dev/null || exit 1
nix flake lock >/dev/null 2>&1
nix flake metadata
rm -rf * # safe, whereas rm -rf $var can be deadly, also rm -rf ./* too, because we can forget to add period in front.
popd >/dev/null || exit 1

rmdir "$out"
