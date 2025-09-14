{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/ab5cd0b7090dede5d76cf3c9914d6c53cafe9801";
in
f.packages.${system}.default
