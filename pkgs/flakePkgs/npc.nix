{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/b6bd056407297431b695e6206c1756b08d2aaa5a";
in
f.packages.${stdenv.hostPlatform.system}.default
