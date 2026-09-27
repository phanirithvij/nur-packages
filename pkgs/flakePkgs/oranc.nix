{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/8592b7ba97381b195eed926c6f24dfa33ce1b497";
in
f.packages.${stdenv.hostPlatform.system}.default
