{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/6e8da9de4c937d5f8c2211406e2790c2cd219bb7";
in
f.packages.${stdenv.hostPlatform.system}.default
