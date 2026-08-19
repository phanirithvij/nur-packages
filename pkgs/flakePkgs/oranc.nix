{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/4b99c0eb7ae074935d6a5aba19dc8ac3d1c9b493";
in
f.packages.${stdenv.hostPlatform.system}.default
