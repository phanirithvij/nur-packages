{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/25eab8ad5028363a4cc1326a94f2c63308a6f0d2";
in
f.packages.${stdenv.hostPlatform.system}.default
