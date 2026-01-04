{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/4957d7ab4bcee6d98c6483865ad03d4c6ec86aab";
in
f.packages.${stdenv.hostPlatform.system}.default
