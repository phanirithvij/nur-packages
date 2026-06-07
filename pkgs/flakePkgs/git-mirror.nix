{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/85730f05a96f83a3dc835e5f6c2424b82190c51b";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
