{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/cffaec3584ccb19ee7991729ba0f8a3266de8fdb";
in
f.packages.${stdenv.hostPlatform.system}.default
