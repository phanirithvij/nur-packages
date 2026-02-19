{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/5897c87e4a0c5744c90a9bf368feacf19c5fffc5";
in
f.packages.${stdenv.hostPlatform.system}.default
