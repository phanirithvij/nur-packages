{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:samestep/npc/56daf3f9d54ec6a93ba1854cf5aadac6757e10de";
in
f.packages.${system}.default
