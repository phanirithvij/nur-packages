{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/3ea492328476b0651d96ef00382a703077633145";
in
f.packages.${system}.default
