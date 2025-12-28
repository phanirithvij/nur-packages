{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/4ae712e81163e35d17bb710276e059be6a73cc67";
in
f.packages.${stdenv.hostPlatform.system}.default
