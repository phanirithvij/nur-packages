{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/dbfe59e5a3e7d4f0f82ea59e49d4b868d0dd5b71";
in
f.packages.${stdenv.hostPlatform.system}.default
