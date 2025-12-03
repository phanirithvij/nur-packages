{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/b4a48303ed9ea74d326ba450ddf5f1514dca76d0";
in
f.packages.${stdenv.hostPlatform.system}.default
