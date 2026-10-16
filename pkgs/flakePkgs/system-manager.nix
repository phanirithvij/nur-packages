{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/c397860e511383fe554ccd2b8366ee34fc88cff4";
in
f.packages.${stdenv.hostPlatform.system}.default
