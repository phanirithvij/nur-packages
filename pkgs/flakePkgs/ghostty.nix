{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/155bd1dbed0c1bfd62a2e1c5eb09b2eb1f11bdfc";
in
f.packages.${system}.default
