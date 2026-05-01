{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/8991d9363ab88bcec3cbeb06f7f177801d50420a";
in
f.packages.${stdenv.hostPlatform.system}.default
