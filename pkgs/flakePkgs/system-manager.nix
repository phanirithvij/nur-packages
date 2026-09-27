{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/a92eb76cb0de5370d6a5ee12ac11b379c76d49a3";
in
f.packages.${stdenv.hostPlatform.system}.default
