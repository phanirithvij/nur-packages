{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/88e5d15fb2caa0e1c568cc0cc603d137f98a4ee8";
in
f.packages.${stdenv.hostPlatform.system}.default
