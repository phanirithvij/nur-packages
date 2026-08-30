{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/e1a32e952def47f91f380ef2d2456aa8f36f4c3b";
in
f.packages.${stdenv.hostPlatform.system}.default
