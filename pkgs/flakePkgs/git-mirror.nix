{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/5e162ad0bf55e632ad9b203080a61b7c387f8183";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
