{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/9cd96e4b64a58b88b9cc260fbfd642b0d10dc716";
in
f.packages.${stdenv.hostPlatform.system}.default
