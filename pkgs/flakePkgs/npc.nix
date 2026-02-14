{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/e856685c9b10fde524154fad8bcfe7ef9bc198f5";
in
f.packages.${stdenv.hostPlatform.system}.default
