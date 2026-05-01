{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/c5de23c638bfbffe231fb42987655b1076ea43fe";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
