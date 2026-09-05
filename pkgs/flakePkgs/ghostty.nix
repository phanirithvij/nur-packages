{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/492300cad104195411d12217dd22f1cd05f31376";
in
f.packages.${stdenv.hostPlatform.system}.default
