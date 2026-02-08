{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/8e3bf91fc5a88d3a76583cf8f593cda410cec5db";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
