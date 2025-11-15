{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/413fc4923e926d25ab212eb86d20523e0b926916";
in
f.packages.${system}.default
