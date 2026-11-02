{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/cba6d1c423c8c88a9f6a093606432e8e447a38f7";
in
f.packages.${stdenv.hostPlatform.system}.default
