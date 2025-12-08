{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/8707cd17932f728b2392f2dfd01b6c35861b759a";
in
f.packages.${stdenv.hostPlatform.system}.default
