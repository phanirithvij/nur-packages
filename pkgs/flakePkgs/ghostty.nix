{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/75e3835a9e74cd092dbd86f0bc07399b0d2d25ce";
in
f.packages.${system}.default
