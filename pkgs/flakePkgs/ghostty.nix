{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/0d61b94c10147691851df37b6ee57d09745b1437";
in
f.packages.${system}.default
