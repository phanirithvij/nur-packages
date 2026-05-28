{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/d1951ae1d5797ebde0d6b26e182adedbb36a4876";
in
f.packages.${stdenv.hostPlatform.system}.default
