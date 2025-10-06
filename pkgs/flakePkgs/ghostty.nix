{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/e4f0c366ff5b5006b6e837dc9350ae53e78e76e9";
in
f.packages.${system}.default
