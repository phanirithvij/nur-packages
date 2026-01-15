{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/83cda9fec8ca6e6431bed5c8e1df6e1b840a9bf5";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
