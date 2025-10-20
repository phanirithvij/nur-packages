{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/6a86f6a6779ae2265aa33c99b4c1fc48bf899a17";
in
f.packages.${system}.default
