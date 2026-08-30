{
  stdenv,
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/21f07f683b9440e105442b963065216f738fbfe2";
in
f.packages.${stdenv.hostPlatform.system}.default
