{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/ee9adf95de628f7d4af1d62667aeb963d2977288";
in
f.packages.${stdenv.hostPlatform.system}.default
