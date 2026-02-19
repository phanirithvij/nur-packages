{
  stdenv,
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/5cb14594fdf1b7241f5c3b9e4ee9c5ae2b94522f";
in
f.packages.${stdenv.hostPlatform.system}.default
