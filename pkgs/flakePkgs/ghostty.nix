{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/6c0e02d1138d5376e4ac2f5e311b225494514a97";
in
f.packages.${stdenv.hostPlatform.system}.default
