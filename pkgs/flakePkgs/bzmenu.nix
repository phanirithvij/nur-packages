{
  stdenv,
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/2cc8eac8ec71cf5d77c337b43d8e8c3219ec6b78";
in
f.packages.${stdenv.hostPlatform.system}.default
