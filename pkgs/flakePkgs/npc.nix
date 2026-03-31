{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/0319f5d2dc1c5d59c563e1528e418620abde29b9";
in
f.packages.${stdenv.hostPlatform.system}.default
