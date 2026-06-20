{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/57a166eee3dcadb881ebdeb9ab322441a58701bd";
in
f.packages.${stdenv.hostPlatform.system}.default
