{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/391290aa4a5ffabea2e9609c006ea45911d256e0";
in
f.packages.${system}.default
