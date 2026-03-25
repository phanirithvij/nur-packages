{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/8b78ce2e8ad618d88cf0332238696ada67376496";
in
f.packages.${stdenv.hostPlatform.system}.default
