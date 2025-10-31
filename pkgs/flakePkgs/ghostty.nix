{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/b043623bb25ca5fad5e836b856a3592d6b232193";
in
f.packages.${system}.default
