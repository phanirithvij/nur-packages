{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/ab62a1408940483e3f1298d3115913b8c7e27659";
in
if system != "x86_64-linux" then null else f.packages.${system}.default
