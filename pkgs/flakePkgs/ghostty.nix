{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/891f442041f3c767c1c851fb46c1877fe64e6406";
in
f.packages.${stdenv.hostPlatform.system}.default
