{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/96f724be6f1411286e8ad0202e3e624c10116a6d";
in
f.packages.${stdenv.hostPlatform.system}.default
