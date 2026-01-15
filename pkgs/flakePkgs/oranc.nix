{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/2749374628c6f7cd281c01d33d9b46369a9feba4";
in
f.packages.${stdenv.hostPlatform.system}.default
