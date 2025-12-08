{
  stdenv,
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/cfea64db14c5f5a7d9ad7f4e92a255bafa766845";
in
f.packages.${stdenv.hostPlatform.system}.default
