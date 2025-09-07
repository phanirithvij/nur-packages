{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/e1627a80e952afce5144d1f826e2ef35cd224cc3";
in
f.packages.${system}.default
