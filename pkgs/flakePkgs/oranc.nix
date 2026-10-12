{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/96b3de7a7c4e6113988c4b8fe029bece3061bc50";
in
f.packages.${stdenv.hostPlatform.system}.default
