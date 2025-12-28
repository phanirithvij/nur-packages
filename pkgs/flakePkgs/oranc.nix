{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/f29681b3afcc556aa5407920c934abc1fa0d5b7f";
in
f.packages.${stdenv.hostPlatform.system}.default
