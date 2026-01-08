{
  stdenv,
}:
let
  f = builtins.getFlake "github:utdemir/nix-tree/4baa2a0f808bbb229a1ef4a35882d763a2b6add4";
in
f.packages.${stdenv.hostPlatform.system}.default
