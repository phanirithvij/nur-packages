{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/be2668cbed39a93bcfaa8dfba791a2f76daf44be";
in
f.packages.${stdenv.hostPlatform.system}.default
