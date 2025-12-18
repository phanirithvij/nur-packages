{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/570cc0a3c34ff7e36e876b24f5b3c61a256ec71b";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
