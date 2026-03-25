{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/d5b6857673f0c6d745503a5b28777193cc2848ec";
in
f.packages.${stdenv.hostPlatform.system}.default
