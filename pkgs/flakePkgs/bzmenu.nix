{
  stdenv,
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/a76a90bf908419e2ab1f8009b29e4cd59483ced4";
in
f.packages.${stdenv.hostPlatform.system}.default
