{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/992987503dfa4f6f043fbe8c16b2d8d9f7903e92";
in
f.packages.${system}.default
