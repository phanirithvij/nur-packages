{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/fcc3643776fb175bbf38ddf57c9e5ea4c981060d";
in
f.packages.${stdenv.hostPlatform.system}.default
