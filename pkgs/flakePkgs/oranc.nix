{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/c6f3a0a84edb99538ae8fa52ce94821cbe2f654c";
in
f.packages.${stdenv.hostPlatform.system}.default
