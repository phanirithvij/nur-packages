{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/48d47346e0c6ad05b6c869ea92649c47723d1cfc";
in
f.packages.${stdenv.hostPlatform.system}.default
