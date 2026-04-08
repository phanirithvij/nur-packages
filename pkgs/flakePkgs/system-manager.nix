{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/f55ceefe988c0d57518e88a98efaed80e121a22c";
in
f.packages.${stdenv.hostPlatform.system}.default
