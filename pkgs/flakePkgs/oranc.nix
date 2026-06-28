{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/9f11894b28234a286bb580fe89c2654161799469";
in
f.packages.${stdenv.hostPlatform.system}.default
