{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/b2880636af477287436e01e8a86238bfa198b0e1";
in
f.packages.${stdenv.hostPlatform.system}.default
