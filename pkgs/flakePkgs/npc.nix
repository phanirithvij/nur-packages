{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:samestep/npc/c18c9b17079270449b1fb2efbdab195c4cc97397";
in
f.packages.${system}.default
