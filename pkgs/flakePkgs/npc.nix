{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/6b2a2f9f8bf600f286410958ab0849972da0e923";
in
f.packages.${stdenv.hostPlatform.system}.default
