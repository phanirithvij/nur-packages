{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/466a004c39c1930083b1d2ea370dea88bd9c4062";
in
f.packages.${system}.default
