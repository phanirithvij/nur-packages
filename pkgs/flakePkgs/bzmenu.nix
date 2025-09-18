{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/41518be061fd1f3412d70b6a5bf4f19845c8c2ea";
in
f.packages.${system}.default
