{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:bachp/git-mirror/5f7be6cd421d83c8412bc7ef37e4dd05bdd616dc";
in
if system != "x86_64-linux" then null else f.packages.${system}.default
