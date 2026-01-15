{
  stdenv,
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/84ab2082934c26d328d5d98ef0e2ef6b339470ae";
in
f.packages.${stdenv.hostPlatform.system}.default
