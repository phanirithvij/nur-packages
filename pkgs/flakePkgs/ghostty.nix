{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/2de5e7d38e1354759211722a8687c0815d2cf02c";
in
f.packages.${stdenv.hostPlatform.system}.default
