{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/15264856f61b112c8beb14fbe3f403f6266c8bdf";
in
f.packages.${stdenv.hostPlatform.system}.default
