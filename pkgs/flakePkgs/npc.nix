{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/717e76b9a0656a39c22020e41e1d764962bb220d";
in
f.packages.${stdenv.hostPlatform.system}.default
