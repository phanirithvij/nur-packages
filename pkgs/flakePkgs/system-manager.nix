{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/43da4c04937a3d0765b7e600f1a2bd0ec22cc44e";
in
f.packages.${stdenv.hostPlatform.system}.default
