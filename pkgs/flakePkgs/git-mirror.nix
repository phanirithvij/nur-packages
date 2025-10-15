{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/d2b6e2aaf5f16a2468ba83a1bbb9556434f0266c";
in
f.packages.${system}.default
