{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/b57f1815a4532f47cbefa4deffc8c53d595b8630";
in
f.packages.${system}.default
