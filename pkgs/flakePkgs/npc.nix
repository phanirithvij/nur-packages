{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/47f804a34b120f74b8dc7293240150bf4bfd7047";
in
f.packages.${stdenv.hostPlatform.system}.default
