{
  stdenv,
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/8af6897c0afc63037a8a3efee4162a380e3a4572";
in
f.packages.${stdenv.hostPlatform.system}.default
