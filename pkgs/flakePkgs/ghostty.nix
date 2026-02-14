{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/61e347a2c278263dd1392c324feaee5fb9712ee5";
in
f.packages.${stdenv.hostPlatform.system}.default
