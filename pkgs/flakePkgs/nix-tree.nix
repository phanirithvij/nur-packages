{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/daff532a0b52c7dc13aa5738c9ee0b43b12ac9e0";
in
f.packages.${system}.default
