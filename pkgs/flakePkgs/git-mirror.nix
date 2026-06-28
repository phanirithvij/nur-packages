{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/61b2fd2a19059e881af5d14156f9d19c20b6454b";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
