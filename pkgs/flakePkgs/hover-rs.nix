{
  stdenv,
}:
let
  f = builtins.getFlake "github:viperML/hover-rs/466763c745e729e0b5275f9c29b19fa9633f89a2";
in
if stdenv.hostPlatform.system != "x86_64-linux" then
  null
else
  f.packages.${stdenv.hostPlatform.system}.default
