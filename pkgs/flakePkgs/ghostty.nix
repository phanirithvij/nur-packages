{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/7092b39445bebfd3178f562eb9e5fa9a95a32332";
in
f.packages.${stdenv.hostPlatform.system}.default
