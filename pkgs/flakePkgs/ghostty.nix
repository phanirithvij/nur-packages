{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/e05a76b5cfc2afaf26ff75a2cb6694457ef8e0fc";
in
f.packages.${stdenv.hostPlatform.system}.default
