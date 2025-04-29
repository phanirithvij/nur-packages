{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/83c58c8e42597eaf28d5ad00f98b8dc6ece8722d";
in
f.packages.${system}.default
