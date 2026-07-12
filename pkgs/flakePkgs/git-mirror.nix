{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/0d61531d6315507ac1d9bc809e30c4b72492e82f";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
