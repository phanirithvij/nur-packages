{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/b3dc3d794513c11633e7c3347935693957744e83";
in
f.packages.${stdenv.hostPlatform.system}.default
