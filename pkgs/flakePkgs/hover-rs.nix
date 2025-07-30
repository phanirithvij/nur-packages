{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:viperML/hover-rs/244e08d959867fe70d2a4db7d02be2e86e304843";
in
if system != "x86_64-linux" then null else f.packages.${system}.default
