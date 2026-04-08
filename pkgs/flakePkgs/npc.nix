{
  stdenv,
}:
let
  f = builtins.getFlake "github:samestep/npc/e19e1ac97d9b56bde96ce994cf0e7077afc0a2e2";
in
f.packages.${stdenv.hostPlatform.system}.default
