{
  fetchpatch2,
  stdenv,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/d48ff7935da72a5a5764ee8c5358d38417b0f337";
in
f.packages.${stdenv.hostPlatform.system}.default
