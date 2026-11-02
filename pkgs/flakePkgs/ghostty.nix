{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/4747d7ff427480f75736dc207d14251b8eabd3c9";
in
f.packages.${stdenv.hostPlatform.system}.default
