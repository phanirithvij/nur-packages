{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:viperML/hover-rs/7a699b1e8a52c416e6d113a000b500752a6c3371";
in
if system == "aarch64-linux" then null else f.packages.${system}.default
