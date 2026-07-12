{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/9be1615adc29d8520053d7b43e6471ae85843aa4";
in
f.packages.${stdenv.hostPlatform.system}.default
