{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/41b9449bfe1676ba43a34a1fc18d2efd208805f8";
in
f.packages.${stdenv.hostPlatform.system}.default
