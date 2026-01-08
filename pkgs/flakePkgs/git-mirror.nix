{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/5590e1e887d6eebba1facd50967c294acd0596ae";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
