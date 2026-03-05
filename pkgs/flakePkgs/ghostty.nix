{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/dd575c716077e0e2d12881fe0c5f65b067978176";
in
f.packages.${stdenv.hostPlatform.system}.default
