{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/02a79b33e86fb473312321081429bffe38229eb3";
in
f.packages.${stdenv.hostPlatform.system}.default
