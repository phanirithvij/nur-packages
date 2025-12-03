{
  stdenv,
}:
let
  f = builtins.getFlake "github:euank/yaml2nix/5672448e2615554fd5a61f2ed2db59c41638f17d";
in
f.packages.${stdenv.hostPlatform.system}.default
