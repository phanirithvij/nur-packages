{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/37bac094c7bf1c602e3bfa115d8d7a70736b0e8e";
in
f.packages.${system}.default
