{
  stdenv,
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/11fd549193e359205bad558294be8afe4806bcbe";
in
f.packages.${stdenv.hostPlatform.system}.default
