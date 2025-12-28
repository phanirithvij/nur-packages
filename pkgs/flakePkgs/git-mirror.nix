{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/5c2cbc3c5eb0e8e11a7c8390745b8ffa10a72528";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
