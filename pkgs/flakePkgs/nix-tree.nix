{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/dc3b7619e4d62ad99c64752456d132904ff2ef86";
in
f.packages.${system}.default
