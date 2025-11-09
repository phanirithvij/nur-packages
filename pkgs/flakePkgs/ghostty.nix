{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/0d5ecc7713d786f6ce30299df5e62b475834a0a0";
in
f.packages.${system}.default
