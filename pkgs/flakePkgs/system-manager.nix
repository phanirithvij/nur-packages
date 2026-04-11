{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/e131823182845180e8a9f48157cc7e3e8907224f";
in
f.packages.${stdenv.hostPlatform.system}.default
