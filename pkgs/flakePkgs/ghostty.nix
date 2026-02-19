{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/74ba971ebaca7e5ce20b1e30ee916a8f0704bd8d";
in
f.packages.${stdenv.hostPlatform.system}.default
