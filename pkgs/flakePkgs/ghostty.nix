{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/2fd3efd6cdf0629f57572af58dff0ae9115ce919";
in
f.packages.${stdenv.hostPlatform.system}.default
