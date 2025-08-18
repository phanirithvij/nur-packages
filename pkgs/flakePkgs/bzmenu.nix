{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/fa094bb0a79d76f8bf0f3fda0415f911d854a20b";
in
f.packages.${system}.default
