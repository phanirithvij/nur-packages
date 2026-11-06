{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/7dc61e113afa23d51ceb92feb186dc708297efb3";
in
f.packages.${stdenv.hostPlatform.system}.default
