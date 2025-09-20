{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/f6e4a2888afc4a5a49446ed0f859287a0523a82d";
in
f.packages.${system}.default
