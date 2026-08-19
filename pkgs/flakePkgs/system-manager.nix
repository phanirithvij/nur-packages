{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/64748b62d6ae74c069234103ce368626bcad8c70";
in
f.packages.${stdenv.hostPlatform.system}.default
