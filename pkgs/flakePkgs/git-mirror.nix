{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/e0a31b902fb3f588efcefdf27bed47a852f91a1c";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
