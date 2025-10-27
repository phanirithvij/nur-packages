{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:samestep/npc/ab05345d0c833759e388d9c2e343a919ecc70c53";
in
f.packages.${system}.default
