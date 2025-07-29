{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/92c1f4b0b9c6fde6d8f79109de71bf4e30831e86";
in
f.packages.${system}.default
