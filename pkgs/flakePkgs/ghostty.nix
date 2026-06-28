{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/07d31666e73bce337b9cece60a884c67fe8906f4";
in
f.packages.${stdenv.hostPlatform.system}.default
