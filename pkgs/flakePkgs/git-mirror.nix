{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/d7a75e04f5440cebcde451e6d6f05076eb2e4b41";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
