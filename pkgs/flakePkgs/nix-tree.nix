{
  stdenv,
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/9513b010bcf96b651adcf81646b27db5332cbf54";
in
f.packages.${stdenv.hostPlatform.system}.default
