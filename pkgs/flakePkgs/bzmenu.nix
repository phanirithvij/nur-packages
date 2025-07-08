{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/a984b561854edc19eb2979f4a842e3acdc4bf3ea";
in
f.packages.${system}.default
