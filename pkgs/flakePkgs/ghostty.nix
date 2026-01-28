{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/685daee01bbd18dc50c066ccfa85828509068a99";
in
f.packages.${stdenv.hostPlatform.system}.default
