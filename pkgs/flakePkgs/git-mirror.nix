{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/27235dcb08cc1b3011f2d816aaf76d7ee530a9c3";
in
f.packages.${system}.default
