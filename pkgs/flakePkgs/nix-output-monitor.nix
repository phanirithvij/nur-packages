{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/5ebe2d0922f5fac056083b9818cb5832731d5418";
in
f.packages.${system}.default
