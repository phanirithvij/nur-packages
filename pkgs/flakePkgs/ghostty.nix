{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/084ff2de67ff24989999fbd4db5d8200f85a826a";
in
f.packages.${system}.default
