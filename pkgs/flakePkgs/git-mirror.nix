{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/d81692eadaa9c160048ee0cb725a61aeffc779b0";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
