{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/05dcf887ef51ea27821f20979493306ec3a19149";
in
f.packages.${stdenv.hostPlatform.system}.default
