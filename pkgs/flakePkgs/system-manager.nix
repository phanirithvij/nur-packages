{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/ac00967c36b3eacddf403efa38c7355989dae82d";
in
f.packages.${stdenv.hostPlatform.system}.default
