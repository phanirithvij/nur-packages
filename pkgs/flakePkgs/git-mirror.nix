{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/d6bdda35240a2a059b0f4fa295f87f07b5d2be0e";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
