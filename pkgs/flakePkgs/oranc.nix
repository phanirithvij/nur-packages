{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/1beab81351be474e025ac9cd1646f8641a02105c";
in
f.packages.${stdenv.hostPlatform.system}.default
