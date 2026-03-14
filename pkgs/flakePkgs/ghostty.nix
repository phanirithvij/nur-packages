{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/1844a5f7bafbade1305e95d515eedcb010aae104";
in
f.packages.${stdenv.hostPlatform.system}.default
