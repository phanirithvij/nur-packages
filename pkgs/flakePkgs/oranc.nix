{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/069a2d30a08a64c640d0024129fcf3fd9a2ecedb";
in
f.packages.${stdenv.hostPlatform.system}.default
