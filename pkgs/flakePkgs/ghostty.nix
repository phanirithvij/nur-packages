{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/4dcb09ada0c0909717d92547623b26eafa50ca8a";
in
f.packages.${stdenv.hostPlatform.system}.default
