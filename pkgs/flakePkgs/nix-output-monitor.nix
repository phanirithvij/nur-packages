{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/1811bbfc0cfbfb3b8a1f10399069f22ca389c1e5";
in
f.packages.${system}.default
