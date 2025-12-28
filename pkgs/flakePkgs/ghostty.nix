{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/38664afde0c17474c8f95cd38489d397a5930580";
in
f.packages.${stdenv.hostPlatform.system}.default
