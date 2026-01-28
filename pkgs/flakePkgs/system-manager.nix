{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/55ff1d85efbd7c49bfba92247d98893aa802a9f2";
in
f.packages.${stdenv.hostPlatform.system}.default
