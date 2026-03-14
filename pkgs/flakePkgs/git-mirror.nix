{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/6eb0a4f83262d7773742beb727f92b182e88562a";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
