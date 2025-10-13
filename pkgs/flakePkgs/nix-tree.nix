{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/9513b010bcf96b651adcf81646b27db5332cbf54";
in
f.packages.${system}.default
