{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/b40acce58dcf77df52231c3798ea58e924647c89";
in
f.packages.${stdenv.hostPlatform.system}.default
