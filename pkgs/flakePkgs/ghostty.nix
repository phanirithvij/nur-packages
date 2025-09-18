{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/1efde5caba2d9f1fbd3e3f1a100f341feca095b4";
in
f.packages.${system}.default
