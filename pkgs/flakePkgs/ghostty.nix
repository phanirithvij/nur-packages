{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/731da5aea543c144140f237a1582ccd833b5481a";
in
f.packages.${system}.default
