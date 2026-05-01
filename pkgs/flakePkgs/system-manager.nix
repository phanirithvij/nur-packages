{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/6eac5ac077960363d3807b1c74f47103d1f62efd";
in
f.packages.${stdenv.hostPlatform.system}.default
