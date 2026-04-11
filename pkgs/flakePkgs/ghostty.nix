{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/7421b4b13f87e101d4bbcedd4da84886ceae4e7b";
in
f.packages.${stdenv.hostPlatform.system}.default
