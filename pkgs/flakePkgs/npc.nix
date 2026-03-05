{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/126095c0af48cbb6a2d515337cce7b11db8517de";
in
f.packages.${stdenv.hostPlatform.system}.default
