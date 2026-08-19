{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/4c6215bb8ee186b5c829457a9a9a9c936f2337bf";
in
f.packages.${stdenv.hostPlatform.system}.default
