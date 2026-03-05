{
  stdenv,
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/4ce94b05c84d133e6a8f9ffbd23edf90699fca19";
in
f.packages.${stdenv.hostPlatform.system}.default
