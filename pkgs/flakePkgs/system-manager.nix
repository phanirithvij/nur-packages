{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/8d2fc63b06506d636338c3a717dd7d5e4458429a";
in
f.packages.${stdenv.hostPlatform.system}.default
