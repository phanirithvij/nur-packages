{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/9f2de282a27a16a835d67788b303211c7a25c6e4";
in
f.packages.${stdenv.hostPlatform.system}.default
