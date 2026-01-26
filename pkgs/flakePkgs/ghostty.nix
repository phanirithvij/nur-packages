{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/061a0ae5656c05525aa812f474dee2ed32700125";
in
f.packages.${stdenv.hostPlatform.system}.default
