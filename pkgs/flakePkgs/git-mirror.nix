{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/49636fb7555fbf6069fd408736092529c874f58b";
in
if system != "x86_64-linux" then null else f.packages.${system}.default
