{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/dbbff53af7aec09ad5cb76b258a0cd1637e48408";
in
f.packages.${system}.default
