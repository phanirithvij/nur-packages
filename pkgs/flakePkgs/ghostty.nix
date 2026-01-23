{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/5de4ff3b9857e1a8b216649908dfbce7ddd51bcb";
in
f.packages.${stdenv.hostPlatform.system}.default
