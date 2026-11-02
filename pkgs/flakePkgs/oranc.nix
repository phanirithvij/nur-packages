{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/072733301d9bc91880e9b0de1f5c08365a9b13c3";
in
f.packages.${stdenv.hostPlatform.system}.default
