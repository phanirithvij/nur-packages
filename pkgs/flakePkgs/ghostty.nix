{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/67ece534237ea5ebf99f2fe5628c56d52e3291f3";
in
f.packages.${system}.default
