{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/2696d50ca42003d648aa0172315b6f4d3b66443e";
in
f.packages.${system}.default
