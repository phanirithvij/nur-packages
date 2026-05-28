{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/17c9c93ebd4a7ee85132f7637001abd5bdded3f2";
in
f.packages.${stdenv.hostPlatform.system}.default
