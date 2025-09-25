{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/a3f59c824fc632f715139e95ffa5996a9812c61d";
in
f.packages.${system}.default
