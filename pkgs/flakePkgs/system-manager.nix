{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/2646bbcb730fbd2a38d3d20948373ec5cd6271ef";
in
f.packages.${stdenv.hostPlatform.system}.default
