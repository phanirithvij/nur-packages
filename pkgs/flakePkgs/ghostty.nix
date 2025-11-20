{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/2d0c0982f58f6615d77d2d6a85007e3dd09ef470";
in
f.packages.${system}.default
