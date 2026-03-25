{
  stdenv,
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/14b50b96a688001d92708fe0297199a52ccc44ee";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
