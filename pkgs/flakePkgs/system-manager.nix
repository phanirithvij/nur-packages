{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/c8fae61f35de240120ede314071798c12d0c2da0";
in
f.packages.${stdenv.hostPlatform.system}.default
