{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/853183e911b70ff7b61057f52fc7b47ea4934238";
in
f.packages.${stdenv.hostPlatform.system}.default
