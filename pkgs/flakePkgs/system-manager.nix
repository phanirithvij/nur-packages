{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/17ca636edcf5aa75787fde0bfc274a8c14eeed8f";
in
f.packages.${stdenv.hostPlatform.system}.default
