{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:samestep/npc/1b553170143ec6b3c9720c1229a96c94d4a5047f";
in
f.packages.${system}.default
