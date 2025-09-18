{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:hakoerber/git-repo-manager/d860b3bf07273cf5cf25d2b7960e8ffe85d22324";
in
f.packages.${system}.default
