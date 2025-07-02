{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/edf70ebea9e2d429723d1c589872b0d1b7863598";
in
f.packages.${system}.default
