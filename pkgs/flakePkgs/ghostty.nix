{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/b764055c3393d26f6c5f1ec373b53c438bcad939";
in
f.packages.${system}.default
