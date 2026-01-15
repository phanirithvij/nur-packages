{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/778c9a60dd6bd9cb72ca9566fd733f7cf05eeeeb";
in
f.packages.${stdenv.hostPlatform.system}.default
