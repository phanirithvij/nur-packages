{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/3ba5e9c24390412fb1dbb08c51008f1efdcff97b";
in
f.packages.${stdenv.hostPlatform.system}.default
