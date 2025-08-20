{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/a909aac2520c9890f7115a10040cc14ae68d667a";
in
f.packages.${system}.default
