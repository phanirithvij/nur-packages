{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/d402a853b5a6a48ae7c03eeb2c1a18d78d1e767b";
in
f.packages.${stdenv.hostPlatform.system}.default
