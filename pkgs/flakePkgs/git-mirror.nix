{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/6296d2440f3f730f0139a07d596d70a42a02c630";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
