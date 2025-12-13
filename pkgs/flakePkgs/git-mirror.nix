{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/d3df64b17365dfc5ece51d4856ddd71103f6aa52";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
