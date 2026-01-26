{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/c2a5e9d2245d8a3b976a8ee32c348fb0051d7ec6";
in
f.packages.${stdenv.hostPlatform.system}.default
