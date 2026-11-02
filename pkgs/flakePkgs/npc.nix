{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/8d936b5add225e2d97d974acc8e0cba20ccc584a";
in
f.packages.${stdenv.hostPlatform.system}.default
