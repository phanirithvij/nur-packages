{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/57b5e1e2507cd65ab8197d39baa4ce2505185510";
in
f.packages.${stdenv.hostPlatform.system}.default
