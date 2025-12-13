{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/7a1ff7779b6b4106ecc9349efb4e1f6afdb1ba4e";
in
f.packages.${stdenv.hostPlatform.system}.default
