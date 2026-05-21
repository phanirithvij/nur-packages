{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/dc1baae12eed1758755e73f8aff7fca5502c6e9f";
in
f.packages.${stdenv.hostPlatform.system}.default
