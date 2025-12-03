{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/9baf37a9b2a1119c697b0eabf32391bfb41ef287";
in
f.packages.${stdenv.hostPlatform.system}.default
