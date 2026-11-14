{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/def6c0b749566cb07b5cfb26206f519b78345be8";
in
f.packages.${stdenv.hostPlatform.system}.default
