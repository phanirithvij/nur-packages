{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/5659cef41f4f2f7a478d0800a11836fa17e64d66";
in
f.packages.${stdenv.hostPlatform.system}.default
