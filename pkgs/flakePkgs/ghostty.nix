{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/5d0a82ba337368f5632ffa6ce4d7c558fa2de9ff";
in
f.packages.${stdenv.hostPlatform.system}.default
