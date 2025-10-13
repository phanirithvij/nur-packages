{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/d367c0ca50e9701989a069f4eba48aeb824d311f";
in
f.packages.${system}.default
