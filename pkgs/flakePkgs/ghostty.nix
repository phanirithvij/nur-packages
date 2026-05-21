{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/46d54ed673a004df09078bee56e809421a82370e";
in
f.packages.${stdenv.hostPlatform.system}.default
