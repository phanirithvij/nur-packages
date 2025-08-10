{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/4742177daa34f3e83d07a2c3ebfe89fcb736e7ef";
in
f.packages.${system}.default
