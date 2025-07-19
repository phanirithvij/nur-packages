{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:Fuwn/yae/8720549ffd8f69832f5c0d7e6686bf115437f242";
in
f.packages.${system}.default
