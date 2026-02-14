{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/d5ea99c795ff6aad883d72487e4202606cf122a2";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
