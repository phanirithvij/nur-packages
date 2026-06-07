{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/4ce012566437212951eac5a35e74e957ba6ba4e4";
in
f.packages.${stdenv.hostPlatform.system}.default
