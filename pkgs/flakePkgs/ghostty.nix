{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/dafb9e89a3470674e0bfd5d9b01edbf1d87f330a";
in
f.packages.${system}.default
