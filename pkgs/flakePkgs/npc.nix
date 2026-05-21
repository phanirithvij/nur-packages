{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/f6e33285ea2cc17b8e5d478b3d6a6d9b053d2d44";
in
f.packages.${stdenv.hostPlatform.system}.default
