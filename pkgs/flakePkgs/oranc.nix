{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/93bf12dfa3846059a5ff12ebfdac4cfdc52e1be2";
in
f.packages.${stdenv.hostPlatform.system}.default
