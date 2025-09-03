{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/225d61de382f110701abbd29762096f0002515c0";
in
f.packages.${system}.default
