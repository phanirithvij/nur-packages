{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/3a78edc5aaa98eeda60ed2842b340ef4a83e9c7d";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
