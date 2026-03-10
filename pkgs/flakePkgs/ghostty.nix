{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/f8a0a45963010e5cb3baa8069dbcc07a60c5d26d";
in
f.packages.${stdenv.hostPlatform.system}.default
