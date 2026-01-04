{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/e9bbd24ceb2aea9b266e2ab747dd7c16cecc3de1";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
