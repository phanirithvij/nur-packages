{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/88efe9c16a7fe42b3ee889e79a38e0f46e1702f4";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
