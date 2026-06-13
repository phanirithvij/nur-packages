{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/887e2a981c0e9d70384c345cc0b2b1cbf169d014";
in
f.packages.${stdenv.hostPlatform.system}.default
