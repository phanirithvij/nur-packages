{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:linyinfeng/oranc/3a9eb02b955b5170e80707c07244ad39a5cc1bbe";
in
f.packages.${system}.default
