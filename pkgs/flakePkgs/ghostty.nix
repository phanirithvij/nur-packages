{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/fa0a982ff26ac851b6cb5d31717ad3deb037be9c";
in
f.packages.${stdenv.hostPlatform.system}.default
