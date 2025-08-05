{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/ae01b4fdb8fd1ef443d8789239fed5bf951e23de";
in
f.packages.${system}.default
