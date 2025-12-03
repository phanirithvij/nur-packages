{
  stdenv,
}:
let
  f = builtins.getFlake "github:Fuwn/yae/ee1e583a3c2584880ee666043ffe1a176bbd88b4";
in
f.packages.${stdenv.hostPlatform.system}.default
