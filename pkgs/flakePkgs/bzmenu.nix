{
  stdenv,
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/69707145933319ed9a1bf8c0d05d7f2034374ef2";
in
f.packages.${stdenv.hostPlatform.system}.default
