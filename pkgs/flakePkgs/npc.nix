{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/395cd005f58e193ae314da79eb9004442cb2dfa2";
in
f.packages.${stdenv.hostPlatform.system}.default
