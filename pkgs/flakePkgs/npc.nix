{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/756a7c06c2742b2d53465fd63bb863ceb03d5ff6";
in
f.packages.${stdenv.hostPlatform.system}.default
