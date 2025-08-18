{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/0f7b559f0f32e588195344b768ae291b2d5c7edc";
in
f.packages.${system}.default
