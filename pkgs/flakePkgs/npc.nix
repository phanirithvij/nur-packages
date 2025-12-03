{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/4e1c898872c4d8a11f89af47ff8fab8f934d7a81";
in
f.packages.${stdenv.hostPlatform.system}.default
