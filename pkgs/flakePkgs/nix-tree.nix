{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/120a2aa654260bea4f7d21b34e11001d48c5e32c";
in
f.packages.${system}.default
