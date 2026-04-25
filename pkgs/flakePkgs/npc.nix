{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/ecc014d8979cb646e56f4bb9089057ed4f80c55b";
in
f.packages.${stdenv.hostPlatform.system}.default
