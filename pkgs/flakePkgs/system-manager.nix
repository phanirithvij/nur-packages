{
  stdenv,
}:
let
  f = builtins.getFlake "github:numtide/system-manager/56661d27dddf18475b2d1f4c06da0e445642ba02";
in
f.packages.${stdenv.hostPlatform.system}.default
