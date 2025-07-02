{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/776d25b0652068e5eeb802670a7adfbbcadf8e8b";
in
f.packages.${system}.default
