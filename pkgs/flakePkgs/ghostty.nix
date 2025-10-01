{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/f41e61cd31a1e5555a9a52ae29da6ee37f150d1f";
in
f.packages.${system}.default
