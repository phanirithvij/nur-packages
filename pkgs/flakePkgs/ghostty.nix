{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/c445f448a7b0e409e71264ca10b302305a62f696";
in
f.packages.${stdenv.hostPlatform.system}.default
