{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/1c2db85aa41c7d929cb23b408229e297dce2758a";
in
f.packages.${stdenv.hostPlatform.system}.default
