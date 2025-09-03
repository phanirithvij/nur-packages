{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/47fefc9deafb7153b1076758a25a890b3d9192ed";
in
f.packages.${system}.default
